class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :product_id
      t.string :name
      t.text :description
      t.decimal :unit_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
