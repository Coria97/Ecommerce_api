require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should belong_to(:created_by).class_name('User').inverse_of(:carts) }
    it { should have_many(:cart_items).dependent(:destroy) }
  end

  describe 'enums' do
    it 'defines the correct enum values' do
      expect(Cart.statuses).to eq('received' => 0, 'pending' => 1, 'processing' => 2, 'completed' => 3, 'canceled' => 4)
    end
  end
end
