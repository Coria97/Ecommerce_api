class Avo::Resources::Product < Avo::BaseResource
  self.includes = []

  def fields
    field :name, as: :text
    field :description, as: :textarea
    field :price, as: :number
    field :stock_quantity, as: :number
    field :sku, as: :text
    field :weight, as: :number
    field :dimensions, as: :text
    field :active, as: :boolean
    field :image, as: :file, is_image: true, as_avatar: true
  end
end
