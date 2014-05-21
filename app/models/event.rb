class Event < ActiveRecord::Base

belongs_to :club

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

validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.search_name(search)
  	if search
  		events = Array.new

  		Event.all.each do |temp_event|
  			if temp_event.name.include? search || temp_event.name == search
  				events.push(temp_event)
  			end
  		end

  		return events
  	else
  		return Event.all
  	end
  end

    def self.search_location(search)
  	if search
  		events = Array.new

  		Event.all.each do |temp_event|
  			if temp_event.location.include? search
  				events.push(temp_event)
  			end
  		end

  		return events
  	else
  		return Event.all
  	end
  end

    def self.search_description(search)
  	if search
  		events = Array.new

  		Event.all.each do |temp_event|
  			if temp_event.description.include? search
  				events.push(temp_event)
  			end
  		end

  		return events
  	else
  		return Event.all
  	end
  end


end
