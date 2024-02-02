class Avo::Resources::CartItem < Avo::BaseResource
  self.includes = []
  self.visible_on_sidebar = false

  def fields
    field :id, as: :id
    field :price, as: :number
    field :quantity, as: :number
    field :cart_id, as: :number
    field :product_id, as: :number
    field :cart, as: :belongs_to
    field :product, as: :belongs_to
  end
end
