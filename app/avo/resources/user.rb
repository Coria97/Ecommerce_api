class Avo::Resources::User < Avo::BaseResource
  self.includes = []
  self.visible_on_sidebar = false

  def fields
    field :id, as: :id
    field :email, as: :text
    field :first_name, as: :text
    field :last_name, as: :text
    field :role, as: :text
    field :jti, as: :text
    field :carts, as: :has_many
  end
end
