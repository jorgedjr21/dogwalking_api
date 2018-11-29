# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walking do
    status { 1 }
    schedule_date { Time.zone.now + 1.day }
    price { 35.00 }
    duration { 180 }
    latitude { 43.7144419 }
    longitude { -79.448393 }
    start_at { Time.zone.now + 1.day }
    end_at { Time.zone.now + 1.day + 3.hours }
  end
end
