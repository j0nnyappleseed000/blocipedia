class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :user

  rescue_from Pundit::NotAuthorizedError do |exception|
   redirect_to wikis_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    wikis_path
  end

  private

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def user
    @user = User.new
  end
end
