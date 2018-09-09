class CreateWholesales < ActiveRecord::Migration[5.2]
  def change
    create_table :wholesales do |t|
      t.references :product, foreign_key: true
      t.references :list, foreign_key: {on_delete: :cascade}
      t.references :user, foreign_key: true
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
