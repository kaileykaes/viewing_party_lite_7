require 'rails_helper'

RSpec.describe 'landing page' do
  before(:each) do
    @user_1 = create(:user)
    @user_2 = create(:user)

    @party_1 = create(:viewing_party)
    @party_2 = create(:viewing_party)

    @viewing_party_user_1 = create(:viewing_party_user, viewing_party: @party_1, user: @user_1)
    @viewing_party_user_1 = create(:viewing_party_user, viewing_party: @party_1, user: @user_2)

    visit root_path
  end

  describe 'page details' do 
    it 'displays application title' do
      expect(page).to have_content('Viewing Party')
    end

    it 'has button to create new user if no user logged in' do
      expect(page).to have_button('Create New User')
    end

    it 'has no button to create new user if user logged in' do
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
      expect(page).to_not have_button('Create New User')
    end

    it 'displays link to return to landing page' do
      expect(page).to have_link('Return Home', href: '/')      
    end
  end

  describe 'Logging In Happy Path' do 
    it 'has a link for Log In' do 
      expect(page).to have_button('Log In')
      click_button "Log In"
      expect(current_path).to eq(login_path)
    end
  end

  describe 'Authorization' do 
    it 'visitor does not see existing users' do 
      expect(page).to_not have_content("Existing Users") 
    end

    it 'registered user can see existing users email' do 
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'

      visit root_path

      expect(page).to have_content("Existing Users")
      within ".user-list" do 
        expect(page).to have_content(@user_1.email)
        expect(page).to have_content(@user_2.email)
      end
    end
  end
end