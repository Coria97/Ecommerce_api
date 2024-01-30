# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  description    :text
#  dimensions     :string
#  name           :string
#  price          :decimal(10, 2)
#  sku            :string           not null
#  stock_quantity :integer
#  weight         :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_products_on_sku  (sku) UNIQUE
#
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :stock_quantity, presence: true
  validates :sku, presence: true, uniqueness: true

  has_many :cart_items, dependent: :restrict_with_exception
  has_one_attached :image

  scope :active, -> { where(active: true) }
end
