# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post '/add_customers_address' => 'customers#add_customers_address'
    end
  end
end
