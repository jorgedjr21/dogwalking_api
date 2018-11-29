# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pets', type: :request do
  let!(:pets) { create_list(:pet, 5) }

  describe '/api/v1/pets' do
    before { get api_v1_pets_path, params: {} }
    it 'must return all pets' do
      expect(response.body).to eq(pets.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/pets/:id' do
    context 'when the pet exists' do
      before { get api_v1_pet_path(id: pets.first.id) }

      it 'must return a pet information' do
        expect(response.body).to eq(pets.first.to_json)
      end

      it 'must have http status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the pet doesn\' exists' do
      before { get api_v1_pet_path(id: 999) }
      it 'must have http status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/pets' do
    context 'when the request is valid' do
      before { post api_v1_pets_path, params: { name: FFaker::Name.name, age: rand(1..20) } }

      it 'must create a new pet' do
        expect(response.body).to eq(Pet.last.to_json)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_pets_path, params: { name: '', age: rand(1..20) } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/pets/:id' do
   context 'when the pet exists' do
     before { put api_v1_pet_path(id: pets.first.id), params: { name: 'Updated Name' } }

     it 'must update the pet' do
       expect(Pet.first.name).to eq('Updated Name')
     end

     it 'must return empty response' do
       expect(response.body).to be_empty
     end

     it 'must have http status 204' do
       expect(response).to have_http_status(:no_content)
     end
   end
  end

  describe 'DELETE /api/v1/pets/:id' do
    context 'when the pet exists' do
      before { delete api_v1_pet_path(id: pets.first.id) }

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
