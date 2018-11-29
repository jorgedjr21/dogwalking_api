# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dog Walkings', type: :request do
  let!(:pet)         { create(:pet) }
  let!(:pet_2)       { create(:pet) }
  let!(:dog_walking) { create(:dog_walking) }
  let!(:dog_walking_pet) { create(:dog_walkings_pet, pet_id: pet.id, dog_walking_id: dog_walking.id) }
  let!(:dog_walking_pet) { create(:dog_walkings_pet, pet_id: pet_2.id, dog_walking_id: dog_walking.id) }

  describe '/api/v1/dog_walkings' do
    before { get api_v1_dog_walkings_path, params: {} }
    it 'must return all dog_walkings' do

      expect(response.body).to eq(DogWalking.all.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
