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
end