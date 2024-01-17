require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            first_name:             'Leo',
            last_name:              'Messi',
            email:                  'Leo.Messi@example.com',
            password:               '18122022',
            password_confirmation:  '18122022'
          }
        }
      end

      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: valid_params
      end

      it_behaves_like 'successful response' do
        let(:expected_keys) do
          %i[user message]
        end
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            first_name:             'Leo',
            last_name:              'Messi',
            email:                  'Leo.Messi@example.com',
            password:               '18122022',
            password_confirmation:  'wrong_password'
          }
        }
      end

      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: invalid_params
      end

      it_behaves_like 'failed response' do
        let(:status_code) { :unprocessable_entity }
        let(:error_message) { 'Sign up failed.' }
      end
    end
  end
end
