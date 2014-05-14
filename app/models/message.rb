class Message < ActiveRecord::Base
	belongs_to :user

	def set_user_id(user_id)
		@user_id = user_id
	end

end
