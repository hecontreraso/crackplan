class ProfileController < ApplicationController

	# before_action :authenticate_user!

	layout "internal"

	# GET /events
	# GET /events.json
	def index
		@user = set_user

		if user_signed_in?
			@is_current_user_profile = (@user.id == current_user.id) ? true : false
			@user.follow_or_unfollow = current_user.get_relationship_label(@user)
		end

		@events = @user.events
		@events.collect do |event|
			event.going_or_join = current_user.get_going_label(event)	if current_user
		end
	end

	def toggle_follow
		@user = set_user
		returned_state = current_user.toggle_follow(@user)
    render json: { returned_state: returned_state }
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

end
