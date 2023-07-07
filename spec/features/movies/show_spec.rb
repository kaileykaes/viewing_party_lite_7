require 'rails_helper'

RSpec.describe 'Movies Show Page' do 
  before(:each) do 
    @user_1 = create(:user)
    @party_1 = create(:viewing_party)
    create(:viewing_party_user, user: @user_1, viewing_party: @party_1)

    movie_response = File.read('spec/fixtures/movie.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/429?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: movie_response)
    @movie = Movie.new(JSON.parse(movie_response, symbolize_names: true))

    actor_response = File.read('spec/fixtures/actor.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/429/credits?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: actor_response)

    review_response = File.read('spec/fixtures/review.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/429/reviews?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: review_response)

      visit "/users/#{@user_1.id}/movies/#{@movie.id}"
  end

  it "has a button to create viewing party" do 
    expect(page).to have_button("Create Viewing Party")
  end

  it "has a button to return to discover page" do 
    expect(page).to have_button("Return to Discover")
    click_button "Return to Discover Page"
    expect(current_path).to eq("/users/#{@user_1.id}/discover")
  end

  it "has movie attributes" do 
    expect(page).to have_content("Title: #{@movie.title}")
    expect(page).to have_content("Vote Average: #{@movie.vote_average}")
    expect(page).to have_content("Run Time: #{@movie.runtime}")
    expect(page).to have_content("Summary: #{@movie.overview}")
    expect(page).to have_content("Western")
  end

  it "has the first ten actors in the cast" do 
    save_and_open_page
    expect(page).to have_content("Actor: Clint Eastwood")
    expect(page).to have_content("Character: Blondie")
    expect(page).to have_content("Actor: Eli Wallach")
    expect(page).to have_content("Character: Tuco Ramirez")
    expect(page).to have_content("Actor: Lee Van Cleef")
    expect(page).to have_content("Character: Sentenza / Angel Eyes")
    expect(page).to have_content("Actor: Aldo Giuffrè")
    expect(page).to have_content("Character: Alcoholic Union Captain")
    expect(page).to have_content("Actor: Luigi Pistilli")
    expect(page).to have_content("Character: Father Pablo Ramirez")
    expect(page).to have_content("Actor: Rada Rassimov")
    expect(page).to have_content("Character: Maria")
    expect(page).to have_content("Actor: Enzo Petito")
    expect(page).to have_content("Character: Storekeeper")
    expect(page).to have_content("Actor: Claudio Scarchilli")
    expect(page).to have_content("Character: Tuco Henchman")
    expect(page).to have_content("Actor: Antonio Casale")
    expect(page).to have_content("Character: Bill Carson / Jackson")
    expect(page).to have_content("Actor: Livio Lorenzon")
    expect(page).to have_content("Character: Baker")

    expect(page).to_not have_content("Sandro Scarchilli")
  end

  it "has all reviews with author of review" do 
    expect(page).to have_content("Author: John Chard")
    expect(page).to have_content("I'm looking for the owner of that horse. He's tall, blonde, he smokes a cigar, and he's a pig!")
    expect(page).to have_content("Rating: 9.0")

    expect(page).to have_content("Author: CRCulver")
    expect(page).to have_content("Sergio Leone's <i>The Good, the Bad, and the Ugly</i> is a classic Western film. Clint Eastwood is the Good,")
    expect(page).to have_content("Rating: 7.0")
  end 
end 