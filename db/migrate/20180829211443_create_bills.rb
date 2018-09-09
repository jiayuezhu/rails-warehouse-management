class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.string :notes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
