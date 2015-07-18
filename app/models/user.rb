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
#  image                  :string
#

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable

  # A user can assist to many events
	has_many :assistants 
	has_many :events, through: :assistants

  # A user can create many events
	has_many :created_events, class_name: "Event", foreign_key: "creator_id"

  # A user can follow another users
	has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :follows, source: :followed

  # A user have followers
	has_many :follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follows, source: :follower

  # A user can request others users to follow them
  has_many :follow_requests, class_name: "FollowRequest", foreign_key: "followed_id", dependent: :destroy
  has_many :request_sended, follow_requests: :follows, source: :follower

  # Others users can request to follow this user
  has_many :follow_requests, class_name: "FollowRequest", foreign_key: "follower_id", dependent: :destroy
  has_many :request_received, through: :follow_requests, source: :followed

	# Avatar uploader using carrierwave
  mount_uploader :image, UserImageUploader

	validates :first_name, presence: true, length: { maximum: 35 }
	validates :last_name, presence: true, length: { maximum: 35 }
	validates :birthdate, presence: true, timeliness: { type: :date, before: Date.today, before_message: "The birthdate is incorrect" }
	validates :gender, presence: true, inclusion: [ "Male", "Female" ]

  attr_accessor :follow_or_unfollow

  # Returns true if the current user is following the other user.
  def is_going_to?(event)
  	events.include?(event)
  end

  def join_event(event)
    Assistant.create(event_id: event.id, user_id: id)
  end

  def quit_event(event)
    Assistant.destroy(event_id: event.id, user_id: id)
  end


	# Send a request to follow an user.
  def request_follow(other_user)
    FollowRequest.create(followed_id: other_user.id)
  end

  # Follows an user.
  def follow(other_user)
    Follow.create(followed_id: other_user.id)
  end

  # Unfollows an user.
  def unfollow(other_user)
    Follow.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Returns true if the current user has requested following the other user.
  def requested?(other_user)
    request_sended.include?(other_user)
  end

end
