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

	belongs_to :creator, class_name: "User", inverse_of: :created_events

	validates :creator_id, presence: true
	validates :date, presence: true, timeliness: { type: :date, after: Date.today, after_message: "Events can only be created from tomorrow" }
	
	# Avatar uploader using carrierwave
  mount_uploader :image, EventImageUploader

  after_save :assist_to_event

  ########################### DECORATORS ###########################
  
  def friendly_date
    if date == Date.today
      return "Today"
    elsif date == Date.tomorrow
      return "Tomorrow"
    else
      return date.strftime("%b %d")
    end
  end

  def friendly_hour
    time.strftime("%l:%M%P") unless time.nil?
  end

  private
  	#Add event creator to assistance list after the creation
    def assist_to_event
      Assistant.create(user_id: creator.id, event_id: id)
    end

end
