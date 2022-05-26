class RemoveColumnCarrierFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :carrier, null: false, foreign_key: true
  end
end
