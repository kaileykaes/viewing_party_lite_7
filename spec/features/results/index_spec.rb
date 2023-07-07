require 'rails_helper'

RSpec.describe 'movie results page' do 
  before(:each) do 
    @user_1 = create(:user)
    @party_1 = create(:viewing_party)
    create(:viewing_party_user, user: @user_1, viewing_party: @party_1)
    
    visit "/users/#{@user_1.id}/movies"
    click_button "Discover Top Rated Movies"
  end

  it "displays title as a link to movie details page" do 
    VCR.use_cassette("top_rated_movies") do 

      expect(page).to have_link("The Godfather")
      expect(page).to have_link("Seven Samurai")
    end
  end

  it "displays vote average of the movie" do 
    within("#top-rated-1") do 
      expect(page).to have_content("8.7")
    end

    within("#top-rated-20") do
      expect(page).to have_content("8.5")
    end

  end
end