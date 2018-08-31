class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :buyer
      t.string :seller
      t.string :notes
      t.float :sub_total
      t.float :tax
      t.float :price_total
      t.references :bill

      t.timestamps
    end
  end
end
