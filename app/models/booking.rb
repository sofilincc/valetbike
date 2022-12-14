class Booking < ApplicationRecord

  belongs_to :user, class_name: :User, foreign_key: :user_id, optional: true
  belongs_to :bike, class_name: :Bike, foreign_key: :bikeid, optional: true
end
