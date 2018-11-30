# frozen_string_literal: true

class DogWalking < ApplicationRecord
  before_create :set_status

  has_many :dog_walkings_pets
  has_many :pets, through: :dog_walkings_pets
  has_many :dog_walking_positions

  validates :schedule_date, presence: true, allow_blank: false
  validates :duration,      presence: true, allow_blank: false
  validates :price,         presence: true, allow_blank: false, numericality: { greater_than: 0 }
  validates :pet_ids,       presence: true, allow_blank: false

  accepts_nested_attributes_for :dog_walkings_pets

  enum duration: %i[thirty_minutes sixty_minutes]
  enum status:   %i[scheduled started finished]


  def self.calculate_price(dog_walking)
    if dog_walking.sixty_minutes?
      35.00 + ((dog_walking.pets.count - 1) * 20.00)
    else
      25.00 + ((dog_walking.pets.count - 1) * 15.00)
    end
  end
  private

  def set_status
    self.status = :scheduled if status.nil?
  end
end
