class Avo::Resources::Product < Avo::BaseResource
  self.includes = []
  self.default_view_type = :grid

  def fields
    field :id, as: :id
    field :name, as: :text
    field :description, as: :textarea
    field :price, as: :number
    field :stock_quantity, as: :number
    field :sku, as: :text
    field :weight, as: :number
    field :dimensions, as: :text
    field :active, as: :boolean
    field :image, as: :file
  end

  self.grid_view = { 
    card: -> do
      {
        cover: record.image, as: :file, link_to_resource: true,
        title: record.name, as: :text, required: true, link_to_resource: true,
       # body: record.description, as: :textarea
        #body: "Price: #{record.price} \nStock: #{record.stock_quantity}", as: :textarea
        body: simple_format("Price: #{record.price} \nStock: #{record.stock_quantity} \nStatus: #{record.active}"), as: :text

      }
      end
    }
end
