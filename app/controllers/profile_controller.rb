class ProfileController < ApplicationController

	before_action :authenticate_user!

	# GET /events
	# GET /events.json
	def index
		@user = current_user
		@events = @user.events
		
		@events.collect do |event|
		    user_id = current_user.id if current_user

	  	    if event.is_current_user_going?(user_id)
		    	event.tag = "Going"
		  	else
		    	event.tag = "Join"
		  	end
		end
	end

end
