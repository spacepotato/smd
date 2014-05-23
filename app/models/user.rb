class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :club_admins
  has_many :clubs, :through => :club_admins
<<<<<<< HEAD
  has_many :event_follows
  has_many :events, :through => :event_follows

=======
  has_many :tickets
>>>>>>> FETCH_HEAD
end


