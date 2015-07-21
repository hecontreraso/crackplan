# == Schema Information
#
# Table name: assistants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assistant < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

  after_save :notify_followers

  private
    def notify_followers
      followers = User.find(user_id).followers
      followers.each do |follower|
        Feed.create(user_id: follower.id, event_id: event_id, feed_creator_id: user_id) 
    	end
    end

end
