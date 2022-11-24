# frozen_string_literal: true

require 'json'

class CustomerAddress
  def get_by_zip_code(zip_code)
    return false if zip_code.blank?

    response = RestClient.get("#{BASE_URL}/#{format('%08d', zip_code)}/json/")
    address = JSON.parse(response)
    address['erro'].present? ? nil : rename_address_keys(address)
  end

  private

  def rename_address_keys(address)
    address['public_place'] = address.delete('logradouro')
    address['complement'] = address.delete('complemento')
    address['neighbourhood'] = address.delete('bairro')
    address['locality'] = address.delete('localidade')
    address.delete('cep')
    address
  end
end
