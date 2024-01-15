class CartMailer < ApplicationMailer
  def cart_created(cart)
    @cart = cart
    mail to: @cart.created_by.email, subject: 'Details of your purchase', content_type: 'text/html'
  end
end
