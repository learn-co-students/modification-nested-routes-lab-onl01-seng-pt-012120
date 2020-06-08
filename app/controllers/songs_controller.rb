class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    # Circumstances to call new
    # 1. Calling directly from songs/new
    # 2. Calling from nested artists/1/songs/new + should validate artist
    #   - if Artist is found assign artist_id to new song
    #   - if the artist isn't found redirect to artists_index 
    # Calling from nested artists
    if params[:artist_id]
      if Artist.find_by(id: params[:artist_id])
        @song = Song.new(artist_id: params[:artist_id])
      else
        redirect_to artists_path
      end
    else
      @song = Song.new
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    
    

    # does the artist exist
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil?
        redirect_to artists_path, alert: "Artist Not Found"
      else
        @song = artist.songs.find_by(id: params[:id])
        @artists = Artist.all
        redirect_to artist_songs_path(artist), alert: "Song not found" if @song.nil?
      end
    else
      @artists = Artist.all
      @song = Song.find_by(id: params[:id])
    end


    # Put this in when we are sure we will need it fired
    
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

