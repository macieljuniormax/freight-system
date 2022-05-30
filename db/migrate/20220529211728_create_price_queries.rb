class CreatePriceQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :price_queries do |t|
      t.decimal :height
      t.decimal :width
      t.decimal :length
      t.decimal :price

      t.timestamps
    end
  end
end
