class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[email name gender generation password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end


end
