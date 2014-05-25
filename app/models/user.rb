class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :club_admins
  has_many :clubs, :through => :club_admins
  has_many :event_follows
  has_many :events, :through => :event_follows
  has_many :tickets

  has_attached_file :image, :styles => {
      :profile => "200x300#" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end


