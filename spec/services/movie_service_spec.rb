require 'rails_helper'

RSpec.describe MovieService do 
  before(:each) do 
    @ms = MovieService.new
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@ms).to be_a MovieService
    end
  end

  describe 'instanc methods' do 
    it '#conn', :vcr do 
      response = @ms.conn
      expect(response).to be_a Faraday::Connection
      expect(response.headers).to have_key('Authorization')
    end

    it '#get_url', :vcr do 
      response = @ms.get_url('movie/top_rated')
      expect(response).to be_a Hash
      expect(response[:results]).to be_a Array

      movie_data = response[:results].first

      expect(movie_data).to have_key(:title)
      expect(movie_data[:title]).to be_a String

      expect(movie_data).to have_key(:vote_average)
      expect(movie_data[:vote_average]).to be_a Float
    end

    it '#top_movies', :vcr do 
      best_movies = @ms.top_movies
      expect(best_movies).to be_a Hash

      first_movie = best_movies[:results].first

      expect(first_movie).to have_key(:title)
      expect(first_movie[:title]).to be_a String

      expect(first_movie).to have_key(:vote_average)
      expect(first_movie[:vote_average]).to be_a Float
    end

    it '#search_movies' do 
      search_results = @ms.search_movies('neverending')
      expect(search_results).to be_a Hash

      first_movie = search_results[:results].first

      expect(first_movie).to have_key(:title)
      expect(first_movie[:title]).to be_a String

      expect(first_movie).to have_key(:vote_average)
      expect(first_movie[:vote_average]).to be_a Float
    end
  end
end