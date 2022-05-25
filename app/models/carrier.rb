class Carrier < ApplicationRecord
  enum status: { active: 0, inactive: 5 }
  validates :brand_name, :corporate_name, :email_domain, :registration_number, :address, :status, presence: true
end
