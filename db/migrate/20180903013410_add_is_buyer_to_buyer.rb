class AddIsBuyerToBuyer < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :is_buyer, :boolean
  end
end
