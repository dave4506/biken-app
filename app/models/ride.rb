class Ride < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :meet_at, presence: true
  validates :title, presence: true

  has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "ride_id",
                                    dependent:   :destroy

  has_many :attendees, through: :active_relationships, source: :user
end
