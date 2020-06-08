module SongsHelper

	def artist_select(artists, f)
		f.collection_select(:artist_id, artists, :id, :name)
	end

end
