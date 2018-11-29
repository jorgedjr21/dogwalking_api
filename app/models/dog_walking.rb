# frozen_string_literal: true

class DogWalking < ApplicationRecord
  has_many :pets, through: :dog_walkings_pets
end
