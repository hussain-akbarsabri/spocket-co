require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  describe 'Customers controller insert_customers action' do
    it 'creates new customers' do
      expect do
        post :insert_customers, params: { format: 'json', 'customers': [{ 'cep': Faker::Number.number(digits: 8), 'name': 'JOSE' }] }
      end.to change(Customer, :count).by(1)
    end

    # it 'creates new customers' do
    #   expect do
    #     post :insert_customers, params: { format: 'json', 'customers': [{ 'cep': 0, 'name': 'JOSE' }] }
    #   end.to eq(false)
    # end
  end
end
