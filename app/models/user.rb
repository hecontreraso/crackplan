class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable

  	has_many :assistants 
  	has_many :events, through: :assistants

	has_many :created_events, :class_name => "Event", :foreign_key => "creator_id"

  	#Returns the user full name
	def full_name
		"#{first_name} #{last_name}"
	end

end
