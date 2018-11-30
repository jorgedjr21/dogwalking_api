# frozen_string_literal: true

module Api
  module V1
    class DogWalkingsController < ApplicationController
      before_action :set_dog_walking, only: %i[show start_walk finish_walk]
      def index
        json_response(DogWalking.all)
      end

      def show
        json_response(@dog_walking)
      end

      def create
        @dog_waling = DogWalking.new(dog_walking_params)
        @dog_waling.save!
        json_response(@dog_waling, :created)
      end

      def start_walk
        status = :forbidden
        if @dog_walking.scheduled?
          @dog_walking.status = :started
          @dog_walking.start_at = Time.zone.now
          @dog_walking.save!
          status = :ok
        end
        json_response(@dog_walking, status)
      end

      def finish_walk
        status = :forbidden
        if @dog_walking.started?
          @dog_walking.status = :finished
          @dog_walking.start_at = Time.zone.now
          @dog_walking.save!
          status = :ok
        end
        json_response(@dog_walking, status)
      end

      private

      def dog_walking_params
        params.permit(:id, :schedule_date, :price, :duration, :start_at, :end_at, pet_ids: [])
      end

      def set_dog_walking
        @dog_walking = DogWalking.find(dog_walking_params[:id])
      end
    end
  end
end
