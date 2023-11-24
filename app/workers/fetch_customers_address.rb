# frozen_string_literal: true

class FetchCustomersAddress
  include Sidekiq::Worker

  def perform
    customers = Customer.includes(:address).where(addresses: { customer_id: nil }).where(retries_count: ...3).first(100)
    fetched_address = []
    customers.each do |customer|
      customer.increment!(:retries_count)
      address = persisted_cep_address(customer.cep)
      address = CustomerAddress.new.get_by_cep(customer.cep) if address.blank?
      if address.present?
        address['customer_id'] = customer.id
        fetched_address << address
      end
    end
    Address.insert_all(fetched_address) if fetched_address.present?
  end

  private

  def persisted_cep_address(cep_code)
    customer = Customer.joins(:address).find_by(cep: cep_code)
    return false if customer.nil?

    address = customer.address.as_json
    address.slice('public_place', 'complement', 'neighbourhood', 'locality', 'uf', 'ibge', 'gia', 'ddd', 'siafi')
  end
end
