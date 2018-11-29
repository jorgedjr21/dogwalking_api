# frozen_string_literal: true

module Api
  module V1
    class DogWalkingsController < ApplicationController
      def index
        json_response(DogWalking.all)
      end
    end
  end
end
