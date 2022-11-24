# frozen_string_literal: true

class AddUniqueIndexOnZipCodeOfCustomer < ActiveRecord::Migration[7.0]
  def change
    add_index :customers, :zip_code, unique: true
  end
end
