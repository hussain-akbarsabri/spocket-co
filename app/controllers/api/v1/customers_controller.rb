# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customers, only: [:add_customers_address]

      def add_customers_address
        return false if @customers.blank?

        Customer.insert_all(@customers, unique_by: %i[zip_code])
        FetchCustomersAddress.perform_async
      end

      private

      def set_customers
        persisted_zip_codes = Customer.pluck(:zip_code)
        @customers = filtered_customers_json.reject { |customer| persisted_zip_codes.include?(customer['zip_code']) }
      end

      def filtered_customers_json
        params[:customers].as_json.each { |customer| customer['zip_code'] = customer.delete('cep').to_i }
      end
    end
  end
end
