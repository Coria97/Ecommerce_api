class Avo::Resources::Cart < Avo::BaseResource
  self.includes = []

  def fields
    field :id, as: :id
    field :created_by_id, as: :number
    field :status, as: :select, enum: ::Cart.statuses
    field :created_by, as: :belongs_to
    field :cart_items, as: :has_many
  end
end
