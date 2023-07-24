require 'rails_helper'

RSpec.describe 'Log In', type: :feature do
  before(:each) do
    @user_1 = create(:user)
  end

  describe 'happy paths' do
    it 'user can visit page' do 
      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Email:')
      expect(page).to have_content('Password')
    end

    it 'user can visit page' do 
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button 'Log In'

      expect(current_path).to eq(user_path(@user_1))
    end
  end

  describe 'sad paths' do 
    it 'no login with bad password' do 
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: 'test'

      click_button 'Log In'

      expect(page).to have_content("Your credentials were wrong. Try again.")
    end
  end

  describe 'logged in' do 
    before(:each) do 
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password  
      click_button 'Log In'
    end

    it 'no link for log in' do 
      expect(page).to_not have_content('Log In')
    end

    it 'no link for create user' do 
      expect(page).to_not have_content('Create New User')
    end

    it 'button to log out' do 
      expect(page).to have_button('Log Out')
    end

    it 'button to log out' do 
      click_button('Log Out')
      expect(current_path).to eq(root_path)
      expect(page).to have_button('Log In')
      expect(page).to have_button('Create New User')
    end
  end
end

# As a logged in user 
# When I visit the landing page
# I no longer see a link to Log In or 
# Create an Account
# But I see a link to Log Out.
# When I click the link to Log Out
# I'm taken to the landing page
# And I can see that the Log Out 
# link has changed back to a Log In link
