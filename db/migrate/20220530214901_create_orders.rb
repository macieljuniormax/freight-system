class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :pickup_address
      t.string :delivery_address
      t.decimal :height
      t.decimal :width
      t.decimal :length
      t.decimal :weight
      t.string :code
      t.string :receiver_name
      t.integer :status
      t.references :vehicle, null: true, foreign_key: true
      t.references :carrier, null: true, foreign_key: true

      t.timestamps
    end
  end
end
