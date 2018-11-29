# frozen_string_literal: true

class DogWalking < ApplicationRecord
  has_many :dog_walkings_pets
  has_many :pets, through: :dog_walkings_pets

  validates :schedule_date, presence: true, allow_blank: false
  validates :duration, presence: true, allow_blank: false
end
