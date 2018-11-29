# frozen_string_literal: true

class Pet < ApplicationRecord
  has_many :dog_walkings_pets
  has_many :dog_walkings, through: :dog_walkings_pets

  validates :name, presence: true, allow_blank: false
end
