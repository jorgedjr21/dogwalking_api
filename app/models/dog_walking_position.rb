# frozen_string_literal: true

class DogWalkingPosition < ApplicationRecord
  belongs_to :dog_walking

  validates :dog_walking_id, presence: true, allow_blank: false
  validates :latitude,       presence: true, allow_blank: false
  validates :longitude,      presence: true, allow_blank: false
end
