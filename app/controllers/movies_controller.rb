class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:movie_search])

    if @facade.search != nil
      @movies = @facade.search_movies
    else
      @movies = @facade.top_movies
    end
  end

  def show

  end
end
