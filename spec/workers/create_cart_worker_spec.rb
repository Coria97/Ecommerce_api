require 'rails_helper'

RSpec.describe CreateCartWorker, type: :worker do
  describe '#perform' do
    let(:client) { FactoryBot.create(:user) }
    let(:product1) { FactoryBot.create(:product) }
    let(:product2) { FactoryBot.create(:product) }
    let!(:order) do
      {
        products: [
          {
            product_id: product1.id,
            quantity:   Faker::Number.between(from: 1, to: 10)
          },
          {
            product_id: product2.id,
            quantity:   Faker::Number.between(from: 1, to: 10)
          }
        ]
      }
    end

    subject(:worker_instance) do
      described_class.new.perform(client.id, order.to_json)
    end

    it 'creates a cart' do
      expect { worker_instance }.to change { Cart.count }.by(1)
    end

    it 'creates a cart with the correct status' do
      worker_instance

      expect(Cart.last.status).to eq(Cart.statuses.key(0))
    end

    it 'creates the cart items' do
      expect { worker_instance }.to change { CartItem.count }.by(2)
    end

    it 'sends a cart creation email' do
      allow(CartMailer).to receive_message_chain(:cart_created, :deliver)

      worker_instance

      expect(CartMailer).to have_received(:cart_created).with(an_instance_of(Cart))
      expect(CartMailer.cart_created(@cart)).to have_received(:deliver)
    end
  end
end
