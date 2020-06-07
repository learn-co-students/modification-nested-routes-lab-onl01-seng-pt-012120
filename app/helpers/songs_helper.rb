module SongsHelper

	def artist_select(artists)
		collection_select(:song, :artist, artists, :id, :name, include_blank: "Choose Artist")
	end

end
