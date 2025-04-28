class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.decimal :price
      t.integer :stock_quantity
      t.boolean :status

      t.timestamps
    end
  end
end
