require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do 
  before(:each) do 
    @user_1 = create(:user)
    @user_2 = create(:user)
    @party_1 = create(:viewing_party)
    @party_2 = create(:viewing_party)
    create(:viewing_party_user, user: @user_1, viewing_party: @party_1)
    create(:viewing_party_user, user: @user_1, viewing_party: @party_2)

    top_20_response = File.read('spec/fixtures/top_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: top_20_response)
    
    search_results = File.read('spec/fixtures/godfather_search.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=Godfather&api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: top_20_response)

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_DB_KEY']}&query=")
      .to_return(status: 200, body: '{"results": []}')

    no_response = File.read('spec/fixtures/no_response.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_DB_KEY']}&query=blahblahblah")
      .to_return(status: 404, body: no_response)
  end

  describe 'Discover Movies Button' do 
    it "button to discover movies routes to user discover page" do 
      visit user_path(@user_1)
      click_on 'Discover Movies'
      expect(current_path).to eq(user_discover_index_path(@user_1))
      expect(current_path).to eq("/users/#{@user_1.id}/discover")
    end

    it 'button to discover movies sad path' do 
      visit user_path(@user_1)
      click_on 'Discover Movies'
      expect(current_path).to_not eq(user_discover_index_path(@user_2))
      expect(current_path).to_not eq("/users/#{@user_2.id}/discover")
    end
  end

  describe "Discover Movies Page" do 
    it 'displays the page title' do 
      visit "/users/#{@user_1.id}/discover"
      expect(page).to have_content('Discover Movies')
    end 

    it 'has button to discover top rated movies' do 
      visit "/users/#{@user_1.id}/discover"
      expect(page).to have_button("Discover Top Rated Movies")

      within "#top-movies" do 
        click_button "Discover Top Rated Movies"

        expect(current_path).to eq("/users/#{@user_1.id}/movies")
      end
    end


  end
end