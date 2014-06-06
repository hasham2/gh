class ApplicationController < ActionController::Base
  # around_filter :user_time_zone, if: :current_user
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :role)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password_confirmation, :password, :current_password, :avatar) }
  end
  def check_enrollment
    if current_user.enrollment_complete?
     #do nothing
    else
      redirect_to  enrollment_steps_path ,notice: 'First complete you enrollment'
    end
  end
  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
    
end
