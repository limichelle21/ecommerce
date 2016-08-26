class Customers::ConfirmationsController < Devise::ConfirmationsController
  layout 'customer'
  skip_before_action :current_order
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  # protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    new_customer_store_session
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    new_customer_store_session
  end
end
