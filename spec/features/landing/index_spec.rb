# frozen_string_literal: true

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
    expect(page).to have_link('Return Home')

    click_link('Return Home')

    expect(current_path).to eq('/')
  end
end
