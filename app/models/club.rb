class Club < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  belongs_to :club_admin

  def self.search(search)
  	if search
  		clubs = Array.new

  		Club.all.each do |temp_club|
  			if temp_club.name.include? search || temp_club.name == search
  				clubs.push(temp_clubs)
  			end
  		end

  		return clubs
  	else
  		return Club.all
  	end
  end

end
