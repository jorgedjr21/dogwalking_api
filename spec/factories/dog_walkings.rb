# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walking do
    status { DogWalking.statuses[:scheduled] }
    schedule_date { Time.zone.now + 1.day }
    price { 35.00 }
    duration { :thirty_minutes }
    start_at { Time.zone.now + 1.day }
    end_at { Time.zone.now + 1.day + 3.hours }

    trait :finished do
      status { DogWalking.statuses[:finished] }
    end

    trait :started do
      status { DogWalking.statuses[:started] }
    end
  end
end
