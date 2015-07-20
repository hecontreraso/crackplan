# == Schema Information
#
# Table name: feeds
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  event_id        :integer
#  feed_creator_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Feed < ActiveRecord::Base
	belongs_to :user, class_name: 'Event', foreign_key: 'user_id'
	belongs_to :event, class_name: 'Event', foreign_key: 'event_id'
	belongs_to :feed_creator, class_name: "User", foreign_key: 'feed_creator_id'
end
