# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  details    :string           default(""), not null
#  where      :string           default(""), not null
#  scope      :string           default(""), not null
#  date       :date             not null
#  time       :time
#  image      :string
#  creator_id :integer
#

class Event < ActiveRecord::Base

	has_many :assistants
	has_many :users, through: :assistants
	belongs_to :creator, :class_name => "User"

	attr_accessor :tag
	# Avatar uploader using carrierwave
  mount_uploader :image, EventImageUploader

	def is_current_user_going?(user_id)
		if Assistant.find_by(event_id: id, user_id: user_id)
			return true
		else
			return false
		end
	end

end
