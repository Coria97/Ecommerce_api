module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        skip_before_action :verify_authenticity_token, only: [:create]
        respond_to :json

        before_action :user_resource, only: :create

        def create
          if @user_resource&.valid_password?(params.dig(:user, :password))
            sign_in(resource_name, @user_resource)
            render json: { message: I18n.t('users.login') }, status: :ok
          else
            render json: { message: I18n.t('errors.users.login') }, status: :unauthorized
          end
        end

        def destroy
          sign_out(current_user)
          render json: { message: I18n.t('users.logout') }, status: :ok
        end

        private

        def user_resource
          @user_resource = User.find_for_database_authentication(email: params.dig(:user, :email))
        end
      end
    end
  end
end
