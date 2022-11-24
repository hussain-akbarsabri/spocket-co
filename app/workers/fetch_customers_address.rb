# frozen_string_literal: true

class FetchCustomersAddress
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform
    @customers = Customer.includes(:address).where(addresses: { customer_id: nil })
    @customers.each do |customer|
      address = CustomerAddress.new.get_by_zip_code(customer.zip_code)
      customer.create_address(address) if address.present?
    end
  end
end
