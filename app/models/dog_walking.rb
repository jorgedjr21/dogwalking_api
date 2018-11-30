# frozen_string_literal: true

class DogWalking < ApplicationRecord
  attr_accessor :real_duration
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

  def as_json(_options = {})
    super(only: %i[id status schedule_date price duration start_at end_at created_at updated_at],
          include: { dog_walking_positions: { only: %i[id longitude latitude created_at updated_at] }, pets: {only: %i[name age]  } },
        ).merge(real_duration: real_duration)
  end

  def self.calculate_price(pets_number, type)
    if type == 'sixty_minutes'
      35.00 + ((pets_number.to_i - 1) * 20.00)
    else
      25.00 + ((pets_number.to_i - 1) * 15.00)
    end
  end

  def calculate_real_duration
    self.real_duration = "#{TimeDifference.between(start_at, end_at).in_minutes.to_i} minuto(s)" if start_at.present? && end_at.present?
  end

  private

  def set_status
    self.status = :scheduled if status.nil?
  end
end
