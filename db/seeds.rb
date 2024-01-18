## Products
### Product Actives
FactoryBot.create_list(:product, 3)
### Product Inactive
FactoryBot.create(:product, active: false)

## Users
FactoryBot.create(:user, email: 'la_bestia_merentiel@boca.com', password: '12345678')

## Admin user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?