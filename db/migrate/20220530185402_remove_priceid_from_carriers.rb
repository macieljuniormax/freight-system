class RemovePriceidFromCarriers < ActiveRecord::Migration[7.0]
  def change
    remove_column :carriers, :price_id, :integer
  end
end
