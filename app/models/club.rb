class Club < ActiveRecord::Base
<<<<<<< HEAD

  has_many :events
  belongs_to :club_admin
=======
  
  has_and_belongs_to_many :events
  has_many :club_admins
  has_many :users, :through => :club_admins
>>>>>>> club-admin-development

  def self.search_name(search)
  	if search
  		clubs = Array.new

  		Club.all.each do |temp_club|
  			if temp_club.name.include? search
  				clubs.push(temp_club)
  			end
  		end

  		return clubs
  	else
  		return Club.all
  	end
  end

  def self.search_weblink(search)
    if search
      clubs = Array.new

      Club.all.each do |temp_club|
        if temp_club.webLink.include? search
          clubs.push(temp_club)
        end
      end

      return clubs
    else
      return Club.all
    end
  end

  def self.search_description(search)
    if search
      clubs = Array.new

      Club.all.each do |temp_club|
        if temp_club.description.include? search
          clubs.push(temp_club)
        end
      end

      return clubs
    else
      return Club.all
    end
  end

end
