# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walkings_pet do
    pet
    dog_walking
  end
end
