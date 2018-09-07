class AddEmailToBuyer < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :email, :string
  end
end
