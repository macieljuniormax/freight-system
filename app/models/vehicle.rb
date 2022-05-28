class Vehicle < ApplicationRecord
  belongs_to :carrier
  before_validation :defines_carrier

  validates :brand_name, :model, :plate, :year_manufacture, :capacity, :carrier, presence: true
  
  private
  def defines_carrier
    user = User.last
    self.carrier = user.carrier
  end
end
