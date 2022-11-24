# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :public_place
      t.string :complement
      t.string :neighbourhood
      t.string :locality
      t.string :uf
      t.integer :ibge
      t.integer :gia
      t.integer :ddd
      t.integer :siafi
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
