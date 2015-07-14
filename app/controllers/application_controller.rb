class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	helper_method :join_event

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :birthdate, :gender, :email, :password, :password_confirmation) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :birthdate, :gender, :email, :current_password, :password, :password_confirmation) }
	end

	# Return true if event state is changed. Otherwise returns false
	def join_event(event)

    assistant = Assistant.find_by(event_id: event.id, user_id: current_user.id)

    respond_to do |format|      
      if assistant
        if event.creator != current_user
          assistant.destroy
          return true
	      else
	      	return false
	      end
      else
        Assistant.create(event_id: event.id, user_id: current_user.id)
        return true
      end

    end
	end

end
