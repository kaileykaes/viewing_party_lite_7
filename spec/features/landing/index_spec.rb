# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landing page' do
  before :each do
    @user_1 = User.create!(name: 'Kevdog', email: 'BigKev@gmail.com', password: 'pass112')
    @user_2 = User.create!(name: 'Shpoinkle', email: 'Shpoink@gmail.com', password: 'passgfga')

    @party_1 = ViewingParty.create!(duration: 120, date: '05-03-2024', time: '03:00:00', movie_id: 1)
    @party_2 = ViewingParty.create!(duration: 140, date: '05-02-2024', time: '05:00:00', movie_id: 2)

    @viewing_party_user_1 = ViewingPartyUser.create!(user_id: @user_1.id, viewing_party_id: @party_1.id)
    @viewing_party_user_2 = ViewingPartyUser.create!(user_id: @user_2.id, viewing_party_id: @party_2.id)

    visit '/'
  end

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
    expect(current_path).to eq("/users/#{@user_1.id}")
  end

  it 'displays link to return to landing page' do
    expect(page).to have_link('Return Home')

    click_link('Return Home')

    expect(current_path).to eq('/')
  end
end
