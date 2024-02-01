class Avo::Resources::Product < Avo::BaseResource
  self.includes = []
  self.default_view_type = :grid

  def fields
    field :name, as: :text
    field :description, as: :textarea
    field :price, as: :number
    field :stock_quantity, as: :number
    field :sku, as: :text
    field :weight, as: :number
    field :dimensions, as: :text
    field :active, as: :boolean
  end

  self.grid_view = {
    card: -> do
    {
      cover: record.image, as: :file, link_to_resource: true,
      title: record.name, as: :text, required: true, link_to_resource: true,
      body: simple_format("Price: #{record.price} \nStock: #{record.stock_quantity} \nActive: #{record.active}"), as: :text
    }
    end
  }

  self.row_controls = -> do
    action Avo::Actions::ReleaseProduct, label: "Release #{record.name}", style: :primary, color: :blue,
      icon: "heroicons/outline/hand-raised" unless params[:view_type] == "grid"
    edit_button title: "Edit this Fish now!"
    show_button title: "Show this Fish now!"
    delete_button title: "Delete this Fish now!", confirmation_message: "Are you sure you want to delete this Fish?"
  end
end
