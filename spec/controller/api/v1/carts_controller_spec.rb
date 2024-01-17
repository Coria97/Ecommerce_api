require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  describe 'POST /create' do
    let(:user) { FactoryBot.create(:user) }

    context 'when the service response 200' do
      let(:product1) { FactoryBot.create(:product) }
      let(:product2) { FactoryBot.create(:product) }
      let(:params) do
        {
          products: [
            {
              product_id: product1.id,
              quantity:   Faker::Number.positive
            },
            {
              product_id: product2.id,
              quantity:   Faker::Number.positive
            }
          ]
        }
      end

      before do
        sign_in user
        post :create, params: params
      end

      it_behaves_like 'successful response' do
        let(:status_code) { 201 }
      end

      it 'queues CreateCartWorker' do
        expect { CreateCartWorker.perform_async }.to enqueue_sidekiq_job
      end
    end

    context 'when the service response 400' do
      before do
        sign_in user
        post :create, params: nil
      end

      it_behaves_like 'failed response' do
        let(:status_code) { :bad_request }
        let(:error_message) { 'Parameters cannot be empty.' }
      end
    end
  end
end
