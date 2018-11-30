# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dog Walkings', type: :request do
  let!(:pet)              { create(:pet) }
  let!(:pet_2)            { create(:pet) }
  let!(:dog_walking)      { create(:dog_walking, pet_ids: [pet.id, pet_2.id]) }
  let!(:past_dog_walking) { create(:dog_walking, pet_ids: [pet.id, pet_2.id], schedule_date: Time.zone.now - 1.day) }

  describe 'GET /api/v1/dog_walkings' do
    context 'without filter param' do
      before { get api_v1_dog_walkings_path, params: {} }
      it 'must return all dog_walkings' do
        expect(response.body).to eq(DogWalking.all.to_json)
      end

      it 'must have status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with filtering future dog_walkings' do
      before { get api_v1_dog_walkings_path, params: { filter: 'future' } }
      it 'must return future dog_walkings' do
        expect(JSON.parse(response.body)).not_to include(JSON.parse(past_dog_walking.to_json))
      end

      it 'must have status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe ' /api/v1/dog_walkings/calculate_price' do
    before { get api_v1_dog_walking_calculate_price_path(pets_number: 2, type: 'sixty_minutes') }

    it 'must return the price json' do
      expect(response.body).to eq({ price: 55.00 }.to_json)
    end
  end

  describe 'GET /api/v1/dog_walkings/:id' do
    context 'when the dog_walking exists' do
      before { get api_v1_dog_walking_path(id: dog_walking.id), params: {} }

      it 'must return a dog_walking information' do
        dog_walking.calculate_real_duration
        expect(response.body).to eq(dog_walking.to_json)
      end

      it 'must have http status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the dog_walking doesn\' exists' do
      before { get api_v1_dog_walking_path(id: 999) }
      it 'must have http status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/dog_walkings' do
    context 'when the request is valid' do
      before { post api_v1_dog_walkings_path, params: { schedule_date: Time.zone.now, price: 55.00, duration: :sixty_minutes, pet_ids: [pet.id, pet_2.id] } }

      it 'must create a new dog_walking' do
        expect(response.body).to eq(DogWalking.last.to_json)
      end

      it 'must have the status scheduled' do
        expect(DogWalking.last.status).to eq(:scheduled.to_s)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_dog_walkings_path, params: { schedule_date: '', price: 0, duration: :sixty_minutes, pet_ids: [] } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/dog_walkings/:dog_walking_id/start_walk' do
    context 'when the dog_walking exists' do
      context 'when the dog_walking is scheduled' do
        let!(:dog_walking_scheduled) { create(:dog_walking, pet_ids: [pet.id, pet_2.id], status: :scheduled) }
        before { put start_walk_api_v1_dog_walking_path(id: dog_walking_scheduled.id) }

        it 'must update the dog_walking status to started' do
          expect(dog_walking_scheduled.reload.status).to eq(:started.to_s)
        end

        it 'must update the dog_walking start_at to now' do
          expect(dog_walking_scheduled.reload.start_at.strftime('%d/%m/%Y %H:%M')).to eq(Time.zone.now.strftime('%d/%m/%Y %H:%M'))
        end

        it 'must have http status 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when the dog_walking is not scheduled' do
        let!(:dog_walking_finished) { create(:dog_walking, :finished, pet_ids: [pet.id, pet_2.id], start_at: Time.zone.now - 3.days) }

        before { put start_walk_api_v1_dog_walking_path(id: dog_walking_finished.id) }
        it 'must not update the dog_walking status to started' do
          expect(dog_walking_finished.reload.status).to eq(:finished.to_s)
        end

        it 'must not update the dog_walking start_at to now' do
          expect(dog_walking_finished.reload.start_at.strftime('%d/%m/%Y %H:%M')).to eq((Time.zone.now - 3.days).strftime('%d/%m/%Y %H:%M'))
        end

        it 'must have http status 403' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'PUT /api/v1/dog_walkings/:dog_walking_id/finish_walk' do
    context 'when the dog_walking exists' do
      context 'when the dog_walking is started' do
        let!(:dog_walking_started) { create(:dog_walking, :started, pet_ids: [pet.id, pet_2.id]) }
        before { put finish_walk_api_v1_dog_walking_path(id: dog_walking_started.id) }

        it 'must update the dog_walking status to started' do
          dog_walking_started
          expect(dog_walking_started.reload.status).to eq(:finished.to_s)
        end

        it 'must update the dog_walking start_at to now' do
          expect(dog_walking_started.reload.start_at.strftime('%d/%m/%Y %H:%M')).to eq(Time.zone.now.strftime('%d/%m/%Y %H:%M'))
        end

        it 'must have http status 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when the dog_walking is not started' do
        let!(:dog_walking_2) { create(:dog_walking, pet_ids: [pet.id, pet_2.id], start_at: Time.zone.now - 3.days) }

        before { put finish_walk_api_v1_dog_walking_path(id: dog_walking_2.id) }
        it 'must not update the dog_walking status to started' do
          expect(dog_walking_2.reload.status).to eq(:scheduled.to_s)
        end

        it 'must not update the dog_walking finish_at to now' do
          expect(dog_walking_2.reload.end_at.strftime('%d/%m/%Y %H:%M')).to eq(dog_walking_2.end_at.strftime('%d/%m/%Y %H:%M'))
        end

        it 'must have http status 403' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
