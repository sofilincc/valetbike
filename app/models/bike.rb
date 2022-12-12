class Bike < ApplicationRecord
  validates_presence_of    :identifier
  validates_uniqueness_of  :identifier

  belongs_to :current_station, class_name: :Station, foreign_key: :current_station_id, optional: true

  belongs_to :current_user, class_name: :User, foreign_key: :user_id, optional: true

end
