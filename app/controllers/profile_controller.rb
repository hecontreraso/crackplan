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

    	if current_user
    		event.going_or_join = current_user.is_going_to?(event) ? "Going" : "Join";
    		@user.follow_or_unfollow = current_user.following?(@user) ? "Unfollow" : "Follow";
 	  	end
		end
	end

	def toggle_follow
		@user = set_user

		if current_user.following?(@user)
			current_user.unfollow(@user)
		else
    	#TODO si el perfil es publico, guardar. Si no, guardar solicitud
			current_user.follow(@user)
			# current_user.request_follow(@user)
		end
    # render json: { state_changed: "changed" } if changed
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

end
