# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    password { 'password' }

    trait :with_accepted_invitation do
      invitation_accepted_at { Time.current }
    end

    trait :locked do
      locked_at { Time.current }
    end
  end
end
