# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :viewing_party do
    date { Faker::Date.forward(days: 7) }
    time { Faker::Time.forward(days: 7, period: :evening) }
    host_id { create(:user).id }
    duration { Faker::Number.within(range: 70..320) }
    movie_id { Faker::Number.within(range: 1..10) }
  end

  factory :viewing_party_user do
    :viewing_party
    :user
  end
end
