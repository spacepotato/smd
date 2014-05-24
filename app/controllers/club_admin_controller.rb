class ClubAdminController < ApplicationController

def new
	@admin = ClubAdmin.new
end

def create
	@admin = ClubAdmin.new(club_admin_params)





	@admin.save
end


private
	def admin_params
      params.require(:club_admin).permit(:club_id, :user_id, :position, :phone)
    end 
end

end
