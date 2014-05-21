class Club < ActiveRecord::Base
  
  has_and_belongs_to_many :events
  has_many :club_admins
  has_many :users, :through => :club_admins

  def self.search(search)
  	if search
  		clubs = Array.new

  		Club.all.each do |temp_club|
  			if temp_club.name.include? search || temp_club.name == search
  				clubs.push(temp_club)
  			end
  		end

  		return clubs
  	else
  		return Club.all
  	end
  end

end
