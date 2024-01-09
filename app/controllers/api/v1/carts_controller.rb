module Api
  module V1
    class CartsController < ApplicationController
      before_action :authenticate_user!

      def create
        Cart.create(status: Cart.received)
        render json: { message: 'Succesfully cart creation' }, status: :created
      end
    end
  end
end
