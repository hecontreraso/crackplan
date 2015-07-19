class Feed < ActiveRecord::Base
	belongs_to :user, class_name: 'Event', foreign_key: 'user_id'
	belongs_to :event, class_name: 'Event', foreign_key: 'event_id'
	belongs_to :feed_creator, class_name: "User", foreign_key: 'feed_creator_id'
end