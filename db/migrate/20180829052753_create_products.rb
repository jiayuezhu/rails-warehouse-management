class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.string :category
      t.string :color
      t.integer :storage
      t.string :brand
      t.float :purchase_price
      t.float :retail_labeled_price
      t.float :wholesale_labeled_price
      t.integer :retail_sold
      t.integer :wholesale_sold

      t.timestamps
    end
  end
end
