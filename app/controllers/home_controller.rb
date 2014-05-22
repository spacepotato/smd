class HomeController < ApplicationController

  def show

    @announcements = Array.new

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
   if user_signed_in?
    EventFollows.all.each do |temp_follow|
      if temp_follow.user_id == current_user.user_id
        temp_event = Event.find(temp_follow.event_id)
        temp_event.comment.each do |temp_comment|
          if temp_comment.is_announcement
            @announcements.push(temp_comment.body)
          end
        end
      end
    end
  end
end
end
