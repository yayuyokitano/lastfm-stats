class Track < ApplicationRecord
	belongs_to :artist
	has_many :scrobble
end
