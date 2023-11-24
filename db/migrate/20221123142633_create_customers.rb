# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :cep, null: false
      t.integer :retries_count, default: 0

      t.timestamps
    end
  end
end
