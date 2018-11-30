# frozen_string_literal: true

module Api
  module V1
    class DogWalkingPositionsController < ApplicationController
      before_action :set_dog_walking_positions, only: %i[show]
      def index
        json_response(DogWalkingPosition.all)
      end

      def show
        json_response(@dog_walking_position)
      end

      def create
        @dog_walking_position = DogWalkingPosition.new(dog_walking_positions_params)
        @dog_walking_position.save!
        json_response(@dog_walking_position, :created)
      end

      private

      def dog_walking_positions_params
        params.permit(:id, :dog_walking_id, :latitude, :longitude)
      end

      def set_dog_walking_positions
        @dog_walking_position = DogWalkingPosition.find_by(id: dog_walking_positions_params[:id], dog_walking_id: dog_walking_positions_params[:dog_walking_id])
      end
    end
  end
end
