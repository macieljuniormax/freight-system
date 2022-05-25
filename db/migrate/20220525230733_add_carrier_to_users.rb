class AddCarrierToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :carrier, null: true, foreign_key: true
  end
end
