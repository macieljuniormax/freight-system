class Price < ApplicationRecord
  belongs_to :carrier
  validates :min_volume, :max_volume, :min_weight, :max_weight, :price_km, :carrier, presence: true
end
