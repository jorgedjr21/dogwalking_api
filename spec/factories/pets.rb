# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { 'Pet DogHero' }
    age { rand(1..20) }
  end
end
