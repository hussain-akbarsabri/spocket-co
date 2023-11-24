# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:address).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cep) }
    it { should validate_length_of(:cep) }
    it { should validate_numericality_of(:cep) }
  end
end
