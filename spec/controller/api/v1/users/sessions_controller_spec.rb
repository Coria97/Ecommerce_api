require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: { user: { email: user.email, password: user.password } }
      end

      it_behaves_like 'successful response'

      it 'signs in the user' do
        expect(subject.current_user).to eq(user)
      end
    end

    context 'with invalid credentials' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: { user: { email: 'invalid@example.com', password: 'invalid_password' } }
      end

      it_behaves_like 'failed response' do
        let(:status_code) { :unauthorized }
        let(:error_message) { 'Invalid email or password.' }
      end

      it 'does not sign in the user' do
        expect(subject.current_user).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the service response 200' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
        delete :destroy
      end

      it_behaves_like 'successful response'

      it 'signs out the user' do
        expect(subject.current_user).to be_nil
      end
    end
  end
end
