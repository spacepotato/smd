class Event < ActiveRecord::Base

has_and_belongs_to_many :clubs

has_attached_file :image
validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.search(search)
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


end
