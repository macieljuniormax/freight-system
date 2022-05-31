class AddPricesToCarrier < ActiveRecord::Migration[7.0]
  def change
    add_reference :carriers, :price, null: true, foreign_key: true
  end
end
