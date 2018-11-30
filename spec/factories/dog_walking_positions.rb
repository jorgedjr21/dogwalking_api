# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walking_position do
    dog_walking { nil }
    latitude { 43.7144419 }
    longitude { -79.448393 }
  end
end
