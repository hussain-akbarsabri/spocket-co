# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post '/insert_customers', to: 'customers#insert_customers'
    end
  end
end
