class MoviesController < ApplicationController
  before_action :find_user, :create_facade

  def index
    # @facade = MovieFacade.new(params[:movie_search])

    if @facade.search != nil
      @movies = @facade.search_movies
    else
      @movies = @facade.top_movies
    end
  end

  def show
    @movie = @facade.movie(params[:id])
    @reviews = @facade.reviews(params[:id])
    @cast = @facade.cast(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def create_facade
    @facade = MovieFacade.new(params[:movie_search])
  end
end
