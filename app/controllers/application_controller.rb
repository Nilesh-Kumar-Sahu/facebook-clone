class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  #
  # def routing_error(error = 'Routing error', status = :not_found, exception=nil)
  #   render_exception(404, "Routing Error", exception)
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end



end
