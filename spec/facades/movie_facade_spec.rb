require 'rails_helper'
require './app/facades/movie_facade'

RSpec.describe MovieFacade do 
  let!(:movie_facade) { MovieFacade.new }

  before(:each) do 
    top_20_response = File.read('spec/fixtures/top_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: top_20_response)
  end

  it "exists and returns attributes" do 
    expect(movie_facade).to be_a(MovieFacade)

    movie = MovieFacade.top_rated.first
    expect(movie.title).to eq("The Godfather")
    expect(movie.vote_average).to eq(8.7)
    expect(movie.vote_count).to eq(18170)
  end
end
