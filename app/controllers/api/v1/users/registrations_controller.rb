module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        def create
          user = User.new(sign_up_params)
          if user.save
            render json: { user: UserSerializer.new(user), message: I18n.t('users.sign_up') }, status: :ok
          else
            render json: { message: I18n.t('errors.users.sign_up') }, status: :unprocessable_entity
          end
        end

        private

        def sign_up_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
