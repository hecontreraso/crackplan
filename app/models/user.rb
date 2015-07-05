class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable

  	has_many :assistants 
  	has_many :events, through: :assistants

	# enum gender: [ :Mujer, :Hombre ]

  	#Returns the user full name
	def full_name
		"#{first_name} #{last_name}"
	end

end
