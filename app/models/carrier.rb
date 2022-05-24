class Carrier < ApplicationRecord
  validates :brand_name, :corporate_name, :email_domain, :registration_number, :address, presence: true
end
