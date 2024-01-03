class Scrobble < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :album
  belongs_to :track

	# TODO: do three upserts to get artist/album/tracks
	# then insert all scrobbles in a single bulk insert
	# requires us to deviate from the rails way, but would
	# gain significant amount of speed
	def self.insert_scrobbles(scrobbles)
		scrobbles.each do |scrobble|
			artist = Artist.find_or_create_by(name: scrobble[:artist])
			Scrobble.create({
				user: User.find(scrobble[:user]),
				artist: artist,
				album: Album.find_or_create_by(artist: artist, name: scrobble[:album]),
				track: Track.find_or_create_by(artist: artist, name: scrobble[:track]),
				scrobbled_at: scrobble[:scrobbled_at]
			})
		end
	end
end
