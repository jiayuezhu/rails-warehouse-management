class CreateDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.references :product, foreign_key: true
      t.references :detail, foreign_key: true
      t.string :parameter

      t.timestamps
    end
  end
end
