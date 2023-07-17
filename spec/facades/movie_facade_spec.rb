require 'rails_helper'

RSpec.describe MovieFacade do 
  before(:each) do 
    @mf = MovieFacade.new 
    @service = MovieService.new
    @mf_search = MovieFacade.new('neverending')
    # json_response = File.read('spec/fixtures/top_movies.json')
    # @stub = stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").to_return(status: 200, body: json_response)
    json = File.read('spec/fixtures/top_movies.json')
    @api_call_response = JSON.parse(json, symbolize_names: true)
  end
  
  describe 'initialize' do 
    it 'exists and has attributes..or not' do 
      expect(@mf).to be_a MovieFacade
      expect(@mf_search).to be_a MovieFacade
      expect(@mf_search.search).to eq('neverending')
    end
  end
  
  describe 'instance methods', :vcr do 
    it '#service' do 
      expect(@mf.service).to be_a MovieService
    end

    it '#create_movies' do 
      movies = @mf.create_movies(@api_call_response)
      expect(movies).to be_a Array
      expect(movies.first).to be_a Movie
      expect(movies.count).to eq(20)
    end
    
    it '#top_rated' do 
      movies = @mf.top_movies

      expect(movies).to be_a Array
      expect(movies.first).to be_a Movie
      expect(movies.count).to eq(20)
    end
    
    it '#search_movies' do 
      movies = @mf_search.search_movies
      expect(movies).to be_a Array
      expect(movies.first).to be_a Movie
      expect(movies.count).to eq(20)
    end
    
    it '#movie' do 
      movie = @mf.movie(238)
      expect(movie).to be_a Movie
      expect(movie.id).to be_a Integer
      expect(movie.genres).to be_a Array
      expect(movie.overview).to be_a String
      expect(movie.runtime).to be_a Integer
      expect(movie.vote_average).to be_a Float
    end
    
    it '#extract_genres' do
      genres = @mf.extract_genres(([{:id=>18, :name=>"Drama"}, {:id=>80, :name=>"Crime"}]))
      expect(genres).to eq(['Drama', 'Crime'])
    end
    
    it '#movie_data' do 
      results = @service.find_movie(238)
      movie_details = @mf.movie_data(results)
      expect(movie_details).to be_a Hash
      expect(movie_details).to have_key(:id)
      expect(movie_details).to have_key(:title)
      expect(movie_details).to have_key(:genres)
      expect(movie_details).to have_key(:runtime)
      expect(movie_details).to have_key(:vote_average)
    end

    it '#cast' do 
      cast = @mf.cast(238)
      expect(cast).to be_a Array
      expect(cast.first).to be_a CastMember
      expect(cast.count).to eq(10)
    end

    it '#reviews' do 
      reviews = @mf.reviews(238)
      first_review = reviews.first
      expect(reviews).to be_a Array
      expect(first_review).to be_a Review
      expect(first_review.author).to be_a String
      expect(first_review.content).to be_a String
      # exepect(first_review.rating).to be_a Float
    end
  end
end