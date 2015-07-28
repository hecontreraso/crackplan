class ProfileController < ApplicationController

  before_action :authenticate_user!, only: [:toggle_follow]

	layout "internal"

	# GET /events
	# GET /events.json
	def index
		@user = set_user

		if @user.privacy == "private" && user_signed_in? == false
			render "forbidden_profile"
		elsif user_signed_in? && current_user == @user
			render "index"
		elsif @user.privacy == "private" && user_signed_in? && current_user.following?(@user).nil?
			@follow_or_unfollow = current_user.get_relationship_label(@user)
			render "forbidden_profile"
		else
			@follow_or_unfollow = current_user.get_relationship_label(@user) if user_signed_in?
			render "index"
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