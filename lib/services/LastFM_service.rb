require "net/http"
require "uri"

module Services
	class LastFMService

		RETRY_TABLE = [0, 1, 5, 10, 60, 300, 600, 1200, 1200]

		def initialize
			@retries = 0
			@params = {}
			@uri = URI("https://ws.audioscrobbler.com/2.0/")
		end

		def get(method, params)
			@params = params
			@params[:method] = method
			@params[:format] = "json"
			@params[:api_key] = "b88b39eaf00f3706c8c7aa00c272cb68"
			@uri.query = URI.encode_www_form(@params)
			exec_get
		end

		def self.parse_scrobbles(res)
			user = res["@attr"]["user"]
			res["track"].map do |track|
				{
					user: user,
					artist: track["artist"]["#text"],
					album: track["album"]["#text"],
					track: track["name"],
					scrobbled_at: Time.at(track["date"]["uts"].to_i)
				}
			end
		end

		private

		def exec_get
			sleep RETRY_TABLE[@retries]
			res = Net::HTTP.get_response(@uri)
			unless res.is_a?(Net::HTTPSuccess)
				return handle_error
			end
			
			hash = JSON.parse(res.body)
			if hash.key?("error")
				return handle_error
			end

			hash
		end

		def handle_error
			@retries += 1
			if @retries < RETRY_TABLE.length
				Rails.logger.warn "LastFM request failed: #{res.inspect}\nBody: #{res.body}"
				exec_get
			else
				Rails.logger.error "Failed to fetch LastFM data after retries: #{res.inspect}\nBody: #{res.body}"
				raise StandardError.new "Failed to fetch LastFM data"
			end
		end
	end
end