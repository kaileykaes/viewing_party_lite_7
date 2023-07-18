require 'rails_helper'

RSpec.describe 'Log In', type: :feature do
  before(:each) do
    @user_1 = create(:user)
  end

  describe 'happy paths' do
    it 'user can visit page' do 
      visit '/'

      click_on 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Email:')
      expect(page).to have_content('Password')
    end

    it 'user can visit page' do 
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      fill_in :password_confirmation, with: @user_1.password

      click_button 'Log In'

      expect(current_path).to eq(user_path(@user_1))
    end
  end
end
# User Story #3 - Logging In Happy Path
# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page

# Notes for User Story #3:
# You will need to create two routes for this user story (one for going to a /login page, and one for actually checking credentials and directing traffic). These routes DO NOT need to be ReSTful right now. We'll talk about how to make them ReSTful tomorrow. For now, you might consider doing something like this:
# GET '/login', to: 'users#login_form'
# login_form will render login_form.html.erb for users to fill in a form with their credentials
# POST '/login', to: 'users#login_user'
# login_user will check if a user exists with the email address that was provided, then check to see if the password, when hashed, matches the secure password stored in the database, and then redirects the user based on if credentials are correct.
