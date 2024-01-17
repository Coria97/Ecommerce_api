require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product, price: 10.0) }

  subject { FactoryBot.create(:cart_item, cart: cart, product: product, quantity: 3) }

  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe 'callbacks' do
    it 'calculates total price before create' do
      expect(subject.price).to eq(30.0)
    end
  end
end
