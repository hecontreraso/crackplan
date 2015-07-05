class RegistrationsController < Devise::RegistrationsController

	# protected

	# def sign_up_params
	# 	params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :email, :password, :password_confirmation)
	# end

	# def account_update_params
	# 	params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :email, :password, :password_confirmation, :current_password)
	# end
end