# username: string
# password_digest: string
#
# password: string virtual
# password_confirmation: string virtual

class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  has_many :subscriptions, dependent: :destroy
  
  def subscribed?
    subscriptions.where(status: 'active').any?
  end
  

end
