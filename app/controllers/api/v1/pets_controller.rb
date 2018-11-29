# frozen_string_literal: true

module Api
  module V1
    class PetsController < ApplicationController
      before_action :set_pet, only: %i[show edit update destroy]

      def index
        json_response(Pet.all)
      end

      def show
        json_response(@pet)
      end

      def create
        @pet = Pet.new(pet_params)
        @pet.save!
        json_response(@pet, :created)
      end

      def update
        @pet.update(pet_params)
        head :no_content
      end

      def destroy
        @pet.destroy
        head :no_content
      end

      private

      def set_pet
        @pet = Pet.find(pet_params[:id])
      end

      def pet_params
        params.permit(:id, :name, :age)
      end
    end
  end
end
