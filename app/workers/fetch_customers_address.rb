# frozen_string_literal: true

require 'sidekiq-scheduler'

class FetchCustomersAddress
  include Sidekiq::Worker

  def perform
    customers = Customer.includes(:address).where(addresses: { customer_id: nil }).where('retries_count < ?', 3).first(100)
    customers.each do |customer|
      customer.increment!(:retries_count)
      address = persisted_cep_address(customer.cep)
      address = CustomerAddress.new.get_by_cep(customer.cep) if address.blank?
      customer.create_address(address) if address.present? && customer.address.nil?
    end
  end

  private

  def persisted_cep_address(cep_code)
    customer = Customer.find_by(cep: cep_code)
    return false if customer&.address.nil?

    address = customer.address.as_json
    address.delete('id')
    address.delete('customer_id')
    address.delete('created_at')
    address.delete('updated_at')
    address
  end
end
