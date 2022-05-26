class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :carrier, optional: true
  before_validation :check_email_domain
  
  private
  def check_email_domain
    domain = self.email.split('@')
    carrier = Carrier.find_by(email_domain: domain[1])

   if carrier
    self.carrier = carrier
   elsif domain[1] == 'sistemadefrete.com.br'
    self.admin = true
   else
    self.email = '---------'
   end

  end
end
