class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :wechat_id
      t.string :company
      t.string :notes

      t.timestamps
    end
  end
end
