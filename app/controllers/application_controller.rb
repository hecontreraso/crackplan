class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!, only: [:accept_follow_request, :decline_follow_request]

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
			:first_name, 
			:last_name, 
			:birthdate, 
			:gender, 
			:email,
			:password, 
			:password_confirmation) 
		}
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
			:first_name, 
			:last_name, 
			:birthdate,
			:gender, 
			:image,
			:email, 
			:bio, 
			:current_password, 
			:password, 
			:password_confirmation
			) 
		}
	end

	def accept_follow_request
		user = set_user
    returned_state = current_user.accept_follow_request(user)
    render json: { returned_state: returned_state }
	end

	def decline_follow_request
    returned_state = current_user.decline_follow_request(set_user)
    render json: { returned_state: returned_state }
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
