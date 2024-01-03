class User < ApplicationRecord
	has_many :scrobble

	def last_cached
		@last_cached
	end

	def cache_new_scrobbles
		cache_scrobbles_after last_cached
	end

	def cache_scrobbles_after(time)
		@last_cached = Time.now
		self.save
		
		cur_page = 1
		caching_finished = false
		until caching_finished
			res = Services::LastFMService.new.get("user.getRecentTracks", {
				from: time.to_i,
				user: @id,
				limit: 1000,
				page: cur_page
			})["recenttracks"]
			caching_finished = is_finished?(res["@attr"])
			scrobbles = Services::LastFMService.parse_scrobbles(res)
			cur_page += 1
			Scrobble.insert_scrobbles scrobbles
			sleep 1
		end
	end

	def is_finished?(meta)
		return meta["page"].to_i * meta["perPage"].to_i >= meta["total"].to_i
	end

end
