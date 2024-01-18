require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: 'api/v1', path_names:
  {
    sign_in:      'login',
    sign_out:     'logout',
    registration: 'signup'
  },
  skip: :all

  as :user do
    post 'api/v1/login', to: 'api/v1/users/sessions#create', as: :user_session
    delete 'api/v1/logout', to: 'api/v1/users/sessions#destroy', as: :destroy_user_session
    post 'api/v1/signup', to: 'api/v1/users/registrations#create', as: :user_registration
  end

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      resources :carts, only: %i[create]
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  get 'up' => 'rails/health#show', as: :rails_health_check
end

# rubocop:disable Layout/LineLength


# == Route Map
#
#                                   Prefix Verb       URI Pattern                                                                                       Controller#Action
#                   new_admin_user_session GET        /admin/login(.:format)                                                                            active_admin/devise/sessions#new
#                       admin_user_session POST       /admin/login(.:format)                                                                            active_admin/devise/sessions#create
#               destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                                                           active_admin/devise/sessions#destroy
#                  new_admin_user_password GET        /admin/password/new(.:format)                                                                     active_admin/devise/passwords#new
#                 edit_admin_user_password GET        /admin/password/edit(.:format)                                                                    active_admin/devise/passwords#edit
#                      admin_user_password PATCH      /admin/password(.:format)                                                                         active_admin/devise/passwords#update
#                                          PUT        /admin/password(.:format)                                                                         active_admin/devise/passwords#update
#                                          POST       /admin/password(.:format)                                                                         active_admin/devise/passwords#create
#                               admin_root GET        /admin(.:format)                                                                                  admin/dashboard#index
#           batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                                                         admin/admin_users#batch_action
#                        admin_admin_users GET        /admin/admin_users(.:format)                                                                      admin/admin_users#index
#                                          POST       /admin/admin_users(.:format)                                                                      admin/admin_users#create
#                     new_admin_admin_user GET        /admin/admin_users/new(.:format)                                                                  admin/admin_users#new
#                    edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                                                             admin/admin_users#edit
#                         admin_admin_user GET        /admin/admin_users/:id(.:format)                                                                  admin/admin_users#show
#                                          PATCH      /admin/admin_users/:id(.:format)                                                                  admin/admin_users#update
#                                          PUT        /admin/admin_users/:id(.:format)                                                                  admin/admin_users#update
#                                          DELETE     /admin/admin_users/:id(.:format)                                                                  admin/admin_users#destroy
#                          admin_dashboard GET        /admin/dashboard(.:format)                                                                        admin/dashboard#index
#              batch_action_admin_products POST       /admin/products/batch_action(.:format)                                                            admin/products#batch_action
#                           admin_products GET        /admin/products(.:format)                                                                         admin/products#index
#                                          POST       /admin/products(.:format)                                                                         admin/products#create
#                        new_admin_product GET        /admin/products/new(.:format)                                                                     admin/products#new
#                       edit_admin_product GET        /admin/products/:id/edit(.:format)                                                                admin/products#edit
#                            admin_product GET        /admin/products/:id(.:format)                                                                     admin/products#show
#                                          PATCH      /admin/products/:id(.:format)                                                                     admin/products#update
#                                          PUT        /admin/products/:id(.:format)                                                                     admin/products#update
#                                          DELETE     /admin/products/:id(.:format)                                                                     admin/products#destroy
#                           admin_comments GET        /admin/comments(.:format)                                                                         admin/comments#index
#                                          POST       /admin/comments(.:format)                                                                         admin/comments#create
#                            admin_comment GET        /admin/comments/:id(.:format)                                                                     admin/comments#show
#                                          DELETE     /admin/comments/:id(.:format)                                                                     admin/comments#destroy
#                             user_session POST       /api/v1/login(.:format)                                                                           api/v1/users/sessions#create
#                     destroy_user_session DELETE     /api/v1/logout(.:format)                                                                          api/v1/users/sessions#destroy
#                        user_registration POST       /api/v1/signup(.:format)                                                                          api/v1/users/registrations#create
#                          api_v1_products GET        /api/v1/products(.:format)                                                                        api/v1/products#index
#                           api_v1_product GET        /api/v1/products/:id(.:format)                                                                    api/v1/products#show
#                             api_v1_carts POST       /api/v1/carts(.:format)                                                                           api/v1/carts#create
#                              sidekiq_web            /sidekiq                                                                                          Sidekiq::Web
#                       rails_health_check GET        /up(.:format)                                                                                     rails/health#show
#         turbo_recede_historical_location GET        /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET        /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET        /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST       /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST       /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST       /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET        /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST       /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST       /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET        /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST       /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET        /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET        /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET        /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST       /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST       /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST       /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET        /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET        /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET        /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET        /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET        /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET        /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET        /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT        /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST       /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
