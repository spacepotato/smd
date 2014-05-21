class HomeController < ApplicationController

  def show

  	@events_retrieved = Event.all.shuffle
  	@events = Array.new
  	@counter = 0

  	@events_retrieved.each do |temp_event|
  		@events.push(temp_event)
  		@counter += 1

  		if @counter > 2
  			return
  		end
  	end

  end
end
