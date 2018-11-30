# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dog Walkings', type: :request do
  let!(:pet)                    { create(:pet) }
  let!(:pet_2)                  { create(:pet) }
  let!(:dog_walking)            { create(:dog_walking, pet_ids: [pet.id, pet_2.id]) }
  let!(:dog_walking_positions)  { create_list(:dog_walking_position, 5, dog_walking: dog_walking) }

  describe 'GET /api/v1/dog_walkings/:dog_walking_id/dog_walking_positions' do
    before { get api_v1_dog_walking_dog_walking_positions_path(dog_walking_id: dog_walking.id), params: {} }
    it 'must return all dog_walkings' do
      expect(response.body).to eq(DogWalkingPosition.all.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/dog_walkings/:dog_walking_id/dog_walking_positions/:id' do
    context 'when the dog_walking_position exists' do
      before { get api_v1_dog_walking_dog_walking_position_path(id: dog_walking_positions.last.id, dog_walking_id: dog_walking.id), params: {} }

      it 'must return a dog_walking_position information' do
        expect(response.body).to eq(dog_walking_positions.last.to_json)
      end

      it 'must have http status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the dog_walking_position doesn\' exists' do
      before { get api_v1_dog_walking_dog_walking_position_path(id: 999, dog_walking_id: dog_walking.id) }
      it 'must have http status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/dog_walkings/:dog_walking_id/dog_walking_positions' do
    context 'when the request is valid' do
      before { post api_v1_dog_walking_dog_walking_positions_path(dog_walking_id: dog_walking.id), params: { dog_walking_id: dog_walking.id, latitude: -21.7844604, longitude: -46.5650731 } }

      it 'must create a new dog_walking' do
        expect(response.body).to eq(DogWalkingPosition.last.to_json)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_dog_walking_dog_walking_positions_path(dog_walking_id: dog_walking.id), params: { dog_walking_id: '', latitude: '', longitude: '' } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
