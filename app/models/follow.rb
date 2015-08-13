# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  status      :string
#

class Follow < ActiveRecord::Base

  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :status, 
    presence: true, 
    inclusion: [ "requested", "following", "blocked" ]

  after_save :add_future_events_to_feed
  before_destroy :delete_feeds, :delete_assistances

  private
    def add_future_events_to_feed
      if status.eql?("following")
        events = User.find(followed_id).future_events
        events.each do |event|
          Feed.create(
            user_id: follower.id,
            event_id: event.id,
            feed_creator_id: followed.id,
            created_at: event.created_at
          )       
        end
      end
    end

    def delete_feeds
        Feed.where(
          user_id: follower.id,
          feed_creator_id: followed.id
        ).delete_all
    end

    def delete_assistances
      if followed.privacy.eql?("private")
        user = User.find(follower.id)
        events = user.events.where(creator_id: followed.id)
        events.each do |event|
          logger.debug "#{follower.id}, #{event.id}"
          Assistant.find_by(user_id: follower.id, event_id: event.id).delete
        end
      end
    end
end