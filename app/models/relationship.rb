class Relationship < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :ride, class_name: "Ride"
  validates :user_id, presence: true
  validates :ride_id, presence: true
end
