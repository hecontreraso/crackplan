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

  after_create :notify_followers
  before_destroy :destroy_notifications

  private
    def notify_followers
      followers = User.find(user_id).followers
      followers.each do |follower|
        Feed.create(
          user_id: follower.id,
          event_id: event_id,
          feed_creator_id: user_id
        ) 
    	end
    end

    def destroy_notifications 
      followers = User.find(user_id).followers
      followers.each do |follower|
        Feed.find_by(
          user_id: follower.id,
          event_id: event_id,
          feed_creator_id: user_id
        ).destroy
      end
    end
end
