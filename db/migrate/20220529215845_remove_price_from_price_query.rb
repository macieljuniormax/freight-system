class RemovePriceFromPriceQuery < ActiveRecord::Migration[7.0]
  def change
    remove_column :price_queries, :price, :decimal
  end
end
