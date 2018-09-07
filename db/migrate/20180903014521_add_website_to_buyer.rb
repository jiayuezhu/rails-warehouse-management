class AddWebsiteToBuyer < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :website, :string
  end
end
