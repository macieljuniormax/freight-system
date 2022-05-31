class RemoveVehivleIdFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :vehicle_id, :integer
  end
end
