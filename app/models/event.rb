class Event < ActiveRecord::Base

	has_many :assistants
	has_many :users, through: :assistants	

	attr_accessor :tag
	# Avatar uploader using carrierwave
  	mount_uploader :image, EventImageUploader

	#Returns how long ago the event was created
	def time_created
		dif = (Time.now.hour - created_at.hour).abs
		if dif < 24
		  return "#{dif}h"
		elsif dif < 168
		  w = (dif/24).floor
		  return "#{w}d"
		else 
		  return ">1w"
		end
	end

	def creator_name
		user_id = assistants.find_by(role: 'C').user_id
		user = User.find(user_id)
		return user.full_name
	end

	def is_current_user_going?(user_id)
		if Assistant.find_by(event_id: id, user_id: user_id)
			return true
		else
			return false
		end
	end

 	def get_time
		time.strftime("%H:%M %p")
	end

end
