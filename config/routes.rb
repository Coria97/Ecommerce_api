require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, path: 'api/v1', path_names:
  {
    sign_in:      'login',
    sign_out:     'logout',
    registration: 'signup'
  },
  skip: :all

  as :user do
    get 'api/v1/login', to: 'api/v1/users/sessions#new', as: :new_session_path
    post 'api/v1/login', to: 'api/v1/users/sessions#create', as: :user_session
    delete 'api/v1/logout', to: 'api/v1/users/sessions#destroy', as: :destroy_user_session
    post 'api/v1/signup', to: 'api/v1/users/registrations#create', as: :user_registration
  end

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      resources :carts, only: %i[create]
      root to: 'home#index'
    end
  end

  constraints ->(request) { request.env['warden'].user&.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  mount Sidekiq::Web => '/sidekiq'

  get 'up' => 'rails/health#show', as: :rails_health_check
end

# rubocop:disable Layout/LineLength



# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                         new_session_path GET    /api/v1/login(.:format)                                                                           api/v1/users/sessions#new
#                             user_session POST   /api/v1/login(.:format)                                                                           api/v1/users/sessions#create
#                     destroy_user_session DELETE /api/v1/logout(.:format)                                                                          api/v1/users/sessions#destroy
#                        user_registration POST   /api/v1/signup(.:format)                                                                          api/v1/users/registrations#create
#                          api_v1_products GET    /api/v1/products(.:format)                                                                        api/v1/products#index
#                           api_v1_product GET    /api/v1/products/:id(.:format)                                                                    api/v1/products#show
#                             api_v1_carts POST   /api/v1/carts(.:format)                                                                           api/v1/carts#create
#                              api_v1_root GET    /api/v1(.:format)                                                                                 api/v1/home#index
#                                      avo        /avo                                                                                              Avo::Engine
#                              sidekiq_web        /sidekiq                                                                                          Sidekiq::Web
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
#
# Routes for Avo::Engine:
#                                root GET    /                                                                                                  avo/home#index
#                           resources GET    /resources(.:format)                                                                               redirect(301, /avo)
#                          dashboards GET    /dashboards(.:format)                                                                              redirect(301, /avo)
# rails_active_storage_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                     active_storage/direct_uploads#create
#                      avo_api_search GET    /avo_api/search(.:format)                                                                          avo/search#index
#                             avo_api GET    /avo_api/:resource_name/search(.:format)                                                           avo/search#show
#                                     POST   /avo_api/resources/:resource_name/:id/attachments(.:format)                                        avo/attachments#create
#                      failed_to_load GET    /failed_to_load(.:format)                                                                          avo/home#failed_to_load
#                                     DELETE /resources/:resource_name/:id/active_storage_attachments/:attachment_name/:attachment_id(.:format) avo/attachments#destroy
#                                     GET    /resources/:resource_name(/:id)/actions(/:action_id)(.:format)                                     avo/actions#show
#                                     POST   /resources/:resource_name(/:id)/actions(/:action_id)(.:format)                                     avo/actions#handle
#              preview_resources_user GET    /resources/users/:id/preview(.:format)                                                             avo/users#preview
#                     resources_users GET    /resources/users(.:format)                                                                         avo/users#index
#                                     POST   /resources/users(.:format)                                                                         avo/users#create
#                  new_resources_user GET    /resources/users/new(.:format)                                                                     avo/users#new
#                 edit_resources_user GET    /resources/users/:id/edit(.:format)                                                                avo/users#edit
#                      resources_user GET    /resources/users/:id(.:format)                                                                     avo/users#show
#                                     PATCH  /resources/users/:id(.:format)                                                                     avo/users#update
#                                     PUT    /resources/users/:id(.:format)                                                                     avo/users#update
#                                     DELETE /resources/users/:id(.:format)                                                                     avo/users#destroy
#           preview_resources_product GET    /resources/products/:id/preview(.:format)                                                          avo/products#preview
#                  resources_products GET    /resources/products(.:format)                                                                      avo/products#index
#                                     POST   /resources/products(.:format)                                                                      avo/products#create
#               new_resources_product GET    /resources/products/new(.:format)                                                                  avo/products#new
#              edit_resources_product GET    /resources/products/:id/edit(.:format)                                                             avo/products#edit
#                   resources_product GET    /resources/products/:id(.:format)                                                                  avo/products#show
#                                     PATCH  /resources/products/:id(.:format)                                                                  avo/products#update
#                                     PUT    /resources/products/:id(.:format)                                                                  avo/products#update
#                                     DELETE /resources/products/:id(.:format)                                                                  avo/products#destroy
#          resources_associations_new GET    /resources/:resource_name/:id/:related_name/new(.:format)                                          avo/associations#new
#        resources_associations_index GET    /resources/:resource_name/:id/:related_name(.:format)                                              avo/associations#index
#         resources_associations_show GET    /resources/:resource_name/:id/:related_name/:related_id(.:format)                                  avo/associations#show
#       resources_associations_create POST   /resources/:resource_name/:id/:related_name(.:format)                                              avo/associations#create
#      resources_associations_destroy DELETE /resources/:resource_name/:id/:related_name/:related_id(.:format)                                  avo/associations#destroy
#                  avo_private_status GET    /avo_private/status(.:format)                                                                      avo/debug#status
#              avo_private_send_to_hq POST   /avo_private/status/send_to_hq(.:format)                                                           avo/debug#send_to_hq
#            avo_private_debug_report GET    /avo_private/debug/report(.:format)                                                                avo/debug#report
#   avo_private_debug_refresh_license POST   /avo_private/debug/refresh_license(.:format)                                                       avo/debug#refresh_license
#                  avo_private_design GET    /avo_private/design(.:format)                                                                      avo/private#design
