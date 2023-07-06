require "rails_helper"
require "./app/poros/movie"
require "./app/services/movie_service"

RSpec.describe Movie do
  before :each do 
    json_response = File.read('spec/fixtures/movie.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/429?api_key=#{ENV['MOVIE_DB_KEY']}")

    @movie = Movie.new(JSON.parse(json_response, symbolize_names: true))
  end

  it "exists and has attributes" do 
    expect(@movie).to be_a(Movie)
    expect(@movie.title).to eq("The Good, the Bad and the Ugly")
    expect(@movie.id).to eq(429)
    expect(@movie.overview).to be_a(String)
    expect(@movie.vote_average).to eq(8.478)
    expect(@movie.vote_count).to eq(7495)
    expect(@movie.poster_path).to eq("/bX2xnavhMYjWDoZp1VM6VnU1xwe.jpg")
  end
end