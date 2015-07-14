class ProfileController < ApplicationController

	before_action :authenticate_user!

	layout "internal"

	# GET /events
	# GET /events.json
	def index
		@user = set_user.decorate
		@is_current_user_profile = (@user.id == current_user.id) ? true : false

		@events = @user.events.decorate
		
		@events.collect do |event|

			event.creator = UserDecorator.new(event.creator)
	    user_id = current_user.id if current_user

  	  if event.is_current_user_going?(user_id)
	    	event.going_or_join = "Going"
	  	else
	    	event.going_or_join = "Join"
	  	end
	  	
		end
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

end
