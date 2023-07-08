require 'rails_helper'

RSpec.describe 'Movie Detail Page', type: :feature do 
  before(:each) do 
    @user_1 = create(:user)
    @top_movies = MovieFacade.new.top_movies
    @movie = @top_movies.first

    visit user_movie_path(@user_1, @movie)
  end

  describe 'movie details' do 
    it 'displays title' do 
      expect(page).to have_content('The Godfather')
    end
  end
end