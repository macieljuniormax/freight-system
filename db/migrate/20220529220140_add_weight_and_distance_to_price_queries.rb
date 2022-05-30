class AddWeightAndDistanceToPriceQueries < ActiveRecord::Migration[7.0]
  def change
    add_column :price_queries, :weight, :decimal
    add_column :price_queries, :distance, :integer
  end
end
