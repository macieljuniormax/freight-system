class Order < ApplicationRecord
  enum status: { pending: 0, approved: 2, disapproved: 4, finished: 6}
  validates :pickup_address, :delivery_address, :height, :width, :length, :weight, :code, :receiver_name, :status, :carrier, presence: true
  belongs_to :carrier
  before_validation :generate_code, on: :create


  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15)
  end
end
