# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :zip_code, uniqueness: true, presence: true

  has_one :address, dependent: :destroy
end
