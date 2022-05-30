class PriceQuery < ApplicationRecord
  validates :height, :width, :length, :weight, :distance, presence: true
end
