class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    token = request.headers['Authorization'].split.last
    @current_user = User.find_by(jti: token)
    if @current_user.nil?
      render json: { message: 'No user logged in' }, status: :unauthorized
    else
      render json: @current_user, status: :ok
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[name]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[name]
    )
  end
end
