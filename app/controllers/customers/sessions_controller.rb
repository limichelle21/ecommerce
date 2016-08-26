class Customers::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
layout 'customer'
skip_before_action :current_order
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  def after_sign_in_path_for(resource)
    store_path
  end

  def after_sign_out_path_for(resource)
    store_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit (:email, :password, :password_confirmation, :type) }
  # end


end
