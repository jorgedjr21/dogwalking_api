# frozen_string_literal: true

class DogWalkingsPet < ApplicationRecord
  belongs_to :pet
  belongs_to :dog_walking
end
