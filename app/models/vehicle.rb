class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :brand_name, :model, :plate, :year_manufacture, :capacity, :carrier, presence: true 
end
