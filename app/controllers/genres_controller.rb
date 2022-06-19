class GenresController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def show
    @movies = @genre.movies
  end

  def edit
    @movies = Movie.all
  end

  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @genre.destroy
    redirect_to genres_url, alert: "Genre successfully deleted!"
  end

  def new
    @genre = Genre.new
    @movies = Movie.all
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to @genre, notice: "Genre successfully created!"
    else
      render :new
    end
  end

  private

  def set_genre
    @genre = Genre.find_by!(slug: params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, movie_ids: [])
  end
end
