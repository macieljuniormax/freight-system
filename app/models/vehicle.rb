class Vehicle < ApplicationRecord
  belongs_to :carrier
  before_validation :defines_carrier
  
  private
  def defines_carrier
    user = User.last
    self.carrier = user.carrier
  end
end
