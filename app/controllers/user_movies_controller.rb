class UserMoviesController < ApplicationController
  def index
    @user = User.find(params[:id])

    if params[:q] == 'top_rated'
      @top_movies = MovieFacade.top_rated 
    elsif params[:search] != (nil || '')
      @search_results = MovieFacade.movie_search(params[:search])
      if @search_results == []
        redirect_to "/users/#{@user.id}/discover"
        flash.alert = "No Results Found"
      end
    else 
      redirect_to "/users/#{@user.id}/discover"
      flash.alert = "No Results Found"
    end
  end
end