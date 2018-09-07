class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :notes
      t.float :sub_total
      t.float :paid
      t.float :owed
      t.boolean :is_finished
      t.float :tax
      t.float :price_total
      t.references :bill
      t.references :buyer

      t.timestamps
    end
  end
end
