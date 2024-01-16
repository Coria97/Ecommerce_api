module Api
  module V1
    class CartsController < ApplicationController
      before_action :authenticate_user!

      def create
        CreateCartWorker.perform_async(current_user.id, create_params.to_json)
        render json: { message: 'Succesfully cart creation' }, status: :created
      end

      private

      def create_params
        params.require(:products).map do |product_params|
          product_params.permit(:product_id, :quantity)
        end
      end
    end
  end
end
