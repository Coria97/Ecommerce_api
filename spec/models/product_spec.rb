require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items).dependent(:restrict_with_exception) }
  end

  describe 'validations' do
    %i[name price stock_quantity sku].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe 'scopes' do
    describe '.active' do
      let!(:active_product) { FactoryBot.create(:product, active: true) }
      let!(:inactive_product) { FactoryBot.create(:product, active: false) }

      it 'returns only active products' do
        expect(Product.active).to include(active_product)
        expect(Product.active).not_to include(inactive_product)
      end
    end
  end
end
