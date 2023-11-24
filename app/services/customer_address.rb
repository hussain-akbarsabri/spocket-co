# frozen_string_literal: true

require 'json'

class CustomerAddress
  TRANSLATION_MAPPING = {
    'logradouro': 'public_place',
    'complemento': 'complement',
    'bairro': 'neighbourhood',
    'localidade': 'locality'
  }.with_indifferent_access.freeze

  BASE_URL = 'https://viacep.com.br/ws'

  def get_by_cep(cep)
    return false if cep.blank?

    begin
      response = RestClient.get("#{BASE_URL}/#{cep}/json")
      address = JSON.parse(response)
      rename_address_keys(address) if address['erro'].blank?
    rescue Exception => e
      Rails.logger.debug "CustomerAddressService Crashed! \n Backrace: #{e.message.backtrace.join('\n')}"
    end
  end

  private

  def rename_address_keys(address)
    address.keys.each do |key|
      address[TRANSLATION_MAPPING[key]] = address.delete(key) if TRANSLATION_MAPPING[key].present?
    end
    address.delete('cep')
    address
  end
end
