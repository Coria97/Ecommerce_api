class CreateCartJob
  include Sidekiq::Job

  def perform(client_id, order)
    initialize_variables(client_id, order)
    create_cart
    process_products
    # Enviar email
  end

  private

  def initialize_variables(client_id, order)
    @client = User.find(client_id)
    @order = JSON.parse(order)
  end

  def create_cart
    @cart = Cart.create!(status: :received, created_by_id: @client.id)
  end

  def process_products
    @order.each do |product|
      create_cart_item(Product.find(product['product_id']), product['quantity'])
    end
  end

  def create_cart_item(product, quantity)
    CartItem.create!(cart: @cart, product: product, price: product.price, quantity: quantity)
  end
end
