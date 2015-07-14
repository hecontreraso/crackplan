class ProfileController < ApplicationController

	before_action :authenticate_user!

	layout "internal"

  # POST /profile/events/:id/join
  def join
		@event = Event.find(params[:id])

    respond_to do |format|
      if join_event(@event)
        format.js {}
      end
    end
  end


	# GET /events
	# GET /events.json
	def index
		@user = current_user.decorate
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

end
