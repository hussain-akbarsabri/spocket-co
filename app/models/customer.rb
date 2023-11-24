# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :cep, presence: true, length: { is: 8 }, numericality: { only_numeric: true }
  validates :name, presence: true

  has_one :address, dependent: :destroy
end
