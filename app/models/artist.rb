class Artist < ApplicationRecord
	has_many :album
	has_many :track
	has_many :scrobble
end
