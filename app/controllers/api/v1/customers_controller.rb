# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController

      def insert_customers
        Customer.insert_all(customer_params)
        FetchCustomersAddress.perform_async

        success_response({ message: 'Customers created!' })
      end

      private

      def customer_params
        params.require(:customers).as_json
      end
    end
  end
end
