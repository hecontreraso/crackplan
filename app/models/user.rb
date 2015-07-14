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

	has_many :assistants 
	has_many :events, through: :assistants

	has_many :created_events, :class_name => "Event", :foreign_key => "creator_id"

	# Avatar uploader using carrierwave
  mount_uploader :image, UserImageUploader

	# validates :first_name, presence: true, length: { maximum: 35 }
	# validates :last_name, presence: true, length: { maximum: 35 }
	# validates :birthdate, presence: true, timeliness: { type: :date, before: Date.today, before_message: "The birthdate is incorrect" }
	# validates :gender, presence: true, inclusion: [ "Male", "Female" ]

end
