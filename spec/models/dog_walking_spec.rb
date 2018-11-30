# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DogWalking, type: :model do
  describe 'When saving a dog walking' do
    context 'that is valid' do
      let!(:pet)         { create(:pet) }
      let!(:pet_2)       { create(:pet) }
      let!(:dog_walking_valid) { build(:dog_walking, pet_ids: [pet.id, pet_2.id]) }

      it 'must create a new dog walking' do
        expect { dog_walking_valid.save }.to change(DogWalking, :count).by(1)
      end
    end

    context 'that is invalid' do
      let!(:dog_walking_invalid) { build(:dog_walking, pet_ids: [], duration: '') }

      it 'must create a new dog walking' do
        expect { dog_walking_invalid.save }.not_to change(DogWalking, :count)
      end
    end
  end

  describe '#calculate_walking_price' do
    let!(:pet)         { create(:pet) }
    let!(:pet_2)       { create(:pet) }
    let!(:pet_3)       { create(:pet) }
    let!(:dog_walking) { create(:dog_walking, pet_ids: [pet.id, pet_2.id, pet_3.id]) }

    it 'must return the value of the walking' do
      expect(DogWalking.calculate_price(dog_walking)).to eq(75.00)
    end
  end
end
