class UserController < ApplicationController
  def show

  	@announcements = Array.new
  	@user = current_user
  	@event_follow = Array.new
  	@belonging_clubs = Array.new

  	if user_signed_in?
    EventFollows.all.each do |temp_follow|
      if temp_follow.user_id == current_user.id
        temp_event = Event.find(temp_follow.event_id)
        @event_follow.push(temp_event)
        temp_event.comments.each do |temp_comment|
          if temp_comment.is_announcement
            @announcements.push( [temp_comment, temp_event] )
	          end
	        end
	      end
	    end
	  end

    ClubAdmin.all.each do |temp_admin|
      if temp_admin.user_id == current_user.id
        @belonging_clubs.push(Club.find(temp_admin.club_id))
      end
    end


  end

  def edit
  	@user = current_user
  end


private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

	def user_params
  		params.require(:user).permit(:image)
	end

end
