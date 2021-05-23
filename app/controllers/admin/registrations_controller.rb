# frozen_string_literal: true

class Admin::RegistrationsController < Devise::RegistrationsController
  layout 'admin'
  before_action :configure_sign_up_params, only: [:create]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    admin_root_path
  end
end
