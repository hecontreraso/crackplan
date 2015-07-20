# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  birthdate              :date
#  gender                 :string
#  privacy                :string           default("public")
#  image                  :string
#

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # A user can assist to many events
	has_many :assistants 
	has_many :events, through: :assistants

  # A user can create many events
	has_many :created_events, class_name: "Event", foreign_key: "creator_id", inverse_of: :creator

  # A user has feeds of his events
  has_many :feeds, inverse_of: :user

  # A user can follow another users
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :follows, source: :followed

  # A user have followers
  # has_many :follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  # has_many :followers, through: :follows, source: :follower


	# Avatar uploader using carrierwave
  mount_uploader :image, UserImageUploader

	validates :first_name, presence: true, length: { maximum: 35 }
	validates :last_name, presence: true, length: { maximum: 35 }
	validates :birthdate, presence: true, timeliness: { type: :date, before: Date.today, before_message: "The birthdate is incorrect" }
  validates :gender, presence: true, inclusion: [ "Male", "Female" ]
	validates :privacy, presence: true, inclusion: [ "private", "public" ]

  attr_accessor :follow_or_unfollow

  #TODO FIX THIS ACCESOR AND MAKE ACTIVERECORD WORK
  def followers
    follower_ids = []
    Follow.where(followed_id: id, status: :following).each do |follow|
      follower_ids << follow.follower_id
    end
    User.where(id: follower_ids)
  end

  def get_going_label(event)
    relationship = Assistant.find_by(event_id: event.id, user_id: id)
    relationship.nil? ? "Join" : "Going"
  end

  # Returns true if the current user is following the other user.
  def is_going_to?(event)
  	events.include?(event)
  end

  def get_relationship_label(other_user)
    relationship = Follow.find_by(follower_id: id, followed_id: other_user.id)
    if relationship.nil?
      return "follow"
    else
      return relationship.status
    end
  end

  # Request to join or quit from an event
  def toggle_assistance(event, current_user)
    unless self == current_user
      return "Not permitted"
    end

    if is_going_to?(event)
      Assistant.find_by(event_id: event.id, user_id: id).destroy
      return "Join"
    else
      event_creator = event.creator
      if event_creator.privacy == "public"
        Assistant.create(event_id: event.id, user_id: id)
        return "Going"
      else
        if following?(event_creator)
          Assistant.create(event_id: event.id, user_id: id)
          return "Going"
        else
          return "Not permitted"
        end
      end
    end
  end 

  # Attempts to follow or unfollow
  def toggle_follow(other_user)
    relationship = Follow.find_by(follower_id: id, followed_id: other_user.id)
    if relationship.nil?
      if other_user.privacy == "public"
        Follow.create(follower_id: id, followed_id: other_user.id, status: :following)
        return "following"
      else
        Follow.create(follower_id: id, followed_id: other_user.id, status: :requested)
        return "requested"
      end
    else
      case relationship.status
      when "requested"
        relationship.destroy
        return "follow"
      when "following"
        relationship.destroy
        return "follow"
      end
      return "user_is_blocked"
    end
  end

  # Attempts to block or unblock
  def toggle_block(other_user)
    relationship = Follow.find_by(follower_id: id, followed_id: other_user.id)
    if relationship
      if relationship.status == "blocked"
        relationship.destroy      
      else
        relationship.destroy
        Follow.create(follower_id: id, followed_id: other_user.id, status: :blocked)
      end
    else
      Follow.create(follower_id: id, followed_id: other_user.id, status: :blocked)
    end
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    Follow.find_by(follower_id: id, followed_id: other_user.id, status: :following)
  end

  # Returns true if the current user has requested to follow the other user.
  def requested?(other_user)
    Follow.find_by(follower_id: id, followed_id: other_user.id, status: :requested)
  end

  # Returns true if the current user has blocked the other user.
  def blocked?(other_user)
    Follow.find_by(follower_id: id, followed_id: other_user.id, status: :blocked)
  end

  ########################### DECORATORS ###########################

  #Returns the user full name
  def full_name
    "#{first_name} #{last_name}"
  end

end
