require 'rails_helper'

RSpec.describe MovieService do 
  before :each do 
    top_20_response = File.read('spec/fixtures/top_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: top_20_response)
  end

  it 'returns top 20 rated movies' do 
    top_movies = MovieService.top_rated_movies

    expect(top_movies).to be_a(Hash)
  end
end