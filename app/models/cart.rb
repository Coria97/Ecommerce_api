# == Schema Information
#
# Table name: carts
#
#  id            :bigint           not null, primary key
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :bigint           not null
#
# Indexes
#
#  index_carts_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
class Cart < ApplicationRecord
  belongs_to :created_by, class_name: 'User', inverse_of: :carts
  has_many :cart_items, dependent: :destroy

  enum status: { received: 0, pending: 1, processing: 2, completed: 3, canceled: 4 }
end
