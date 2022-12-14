# username: string
# password_digest: string
#
# password: string virtual
# password_confirmation: string virtual

class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  has_many :subscriptions, dependent: :destroy
  has_many :bookings, class_name: :Booking, foreign_key: :user_id
<<<<<<< HEAD
  has_many :bookings, class_name: :Booking, foreign_key: :user_id

=======
<<<<<<< HEAD
  has_many :bookings, class_name: :Booking, foreign_key: :user_id

=======
>>>>>>> 64453e2374302f900424e5f8c7cc75bf7d97b5c6


  
  def subscribed?
    subscriptions.where(status: 'active').any?
  end
  

end
