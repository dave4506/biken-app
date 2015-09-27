class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable,
    :validatable, :authentication_keys => [:login]
  attr_accessor :login
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }
  validates :fullname,
    :presence => true
  has_many :rides, dependent: :destroy
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"

  has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "user_id",
                                    dependent:   :destroy
  has_many :event, through: :active_relationships, source: :ride

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_hash).first
      end
    end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def going(attend_ride)
    active_relationships.create(ride_id: attend_ride.id)
  end

  def ungoing(attend_ride)
    active_relationships.find_by(ride_id: attend_ride.id).destroy
  end

  def going?(attend_ride)
    event.include?(attend_ride)
  end

end
