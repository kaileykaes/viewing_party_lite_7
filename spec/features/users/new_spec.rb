require 'rails_helper'

RSpec.describe '/register', type: :feature do
  describe 'new user creation' do
    before(:each) do
      visit register_path
    end

    describe 'registration' do 
      it 'form to register has a descriptive header' do
        expect(page).to have_content('Register a New User')
      end

      it 'has a form to register' do
        expect(page).to have_field('Name:')
        expect(page).to have_field('Email:')
        expect(page).to have_field('Password:')
        expect(page).to have_field('Password Confirmation:')
        expect(page).to have_button('Register')
      end

      it 'form can be filled out' do
        fill_in('Name:', with: 'John Jacob Jingleheimer Schmidt')
        fill_in('Email:', with: 'jjjs@gmail.com')
        fill_in('Password:', with: 'test')
        fill_in('Password Confirmation:', with: 'test')
        click_button 'Register'
        expect(current_path).to_not eq(register_path)
        # expect(page).to have_content('John Jacob Jingleheimer Schmidt')
      end
    end
    
    it 'if email validation fails, try again' do
      user1 = create(:user)
      fill_in('Name:', with: 'John Jacob Jingleheimer Schmidt')
      fill_in('Email:', with: user1.email)
      fill_in('Password:', with: 'test')
      fill_in('Password Confirmation:', with: 'test')
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'missing name field' do 
      fill_in('Email:', with: 'jjjs@gmail.com')
      fill_in('Password:', with: 'test')
      fill_in('Password Confirmation:', with: 'test')
      click_button 'Register'
  
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'cannot register with bad credentials' do 
      fill_in('Name:', with: 'John Jacob Jingleheimer Schmidt')
      fill_in('Email:', with: 'jjjs@gmail.com')
      fill_in('Password:', with: 'test')
      fill_in('Password Confirmation:', with: 'chest')
      click_button 'Register'
  
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
# sad path: field isn't filled in
