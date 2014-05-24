class Club < ActiveRecord::Base
 

  has_many :club_admins
  accepts_nested_attributes_for :club_admins
  has_many :clubs_events
  has_many :events, :through => :club_events
  has_many :users, :through => :club_admins

  has_attached_file :banner, :styles => {
      :thumb => "100x100#",
      :small  => "150x150#",
      :medium => "300x300#",
      :banner => "900x200#"}

  has_attached_file :image, :styles => {
      :thumb => "100x100#",
      :small  => "150x150#",
      :medium => "300x300#" }

  has_attached_file :image2, :styles => {
      :thumb => "100x100#",
      :small  => "150x150#",
      :medium => "300x300#" }

  has_attached_file :image3, :styles => {
      :thumb => "100x100#",
      :small  => "150x150#",
      :medium => "300x300#" }

  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :image2, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :image3, :content_type => /\Aimage\/.*\Z/

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
