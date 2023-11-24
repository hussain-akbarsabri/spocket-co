require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  describe 'Customers controller insert_customers action' do
    it 'creates new customers' do
      expect do
        post :insert_customers, params: { format: 'json', 'customers': [{ 'cep': Faker::Number.number(digits: 8),
                                                                          'name': Faker::Name.name }] }
      end.to change(Customer, :count).by(1)
      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body, { symbolize_names: true })
      expect(response_body[:data][:message]).to eq('Customers created!')
    end
  end
end
