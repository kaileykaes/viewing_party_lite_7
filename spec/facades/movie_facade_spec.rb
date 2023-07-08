require 'rails_helper'

RSpec.describe MovieFacade do 
  before(:each) do 
    @mf = MovieFacade.new 
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

  describe 'class methods', :vcr do 
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
  end
end