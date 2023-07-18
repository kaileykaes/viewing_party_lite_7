require 'rails_helper'

RSpec.describe 'landing page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)

    @party_1 = create(:viewing_party)
    @party_2 = create(:viewing_party)

    @viewing_party_user_1 = create(:viewing_party_user, viewing_party: @party_1, user: @user_1)
    @viewing_party_user_1 = create(:viewing_party_user, viewing_party: @party_1, user: @user_2)

    visit '/'
  end

  describe 'page details' do 
    it 'displays application title' do
      expect(page).to have_content('Viewing Party')
    end

    it 'has button to create new user' do
      expect(page).to have_button('Create New User')
    end

    it 'displays existing users with links to users dashboard' do
      expect(page).to have_link(@user_1.name)
      expect(page).to have_link(@user_2.name)

      click_link(@user_1.name)
      expect(current_path).to eq(user_path(@user_1.id))
    end

    it 'displays link to return to landing page' do
      expect(page).to have_link('Return Home', href: '/')      
    end
  end

  describe 'Logging In Happy Path' do 
    it 'has a link for Log In' do 
      expect(page).to have_link('Log In', href: '/login')
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
