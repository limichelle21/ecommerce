class SessionsController < ApplicationController
# before_filter :configure_sign_in_params, only: [:create]
layout 'customer'

skip_before_action :current_order

  # GET /resource/sign_in
  def new 
  end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to store_path(store_id: current_store.id)
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  # DELETE /resource/sign_out
  def destroy
    destroy_session(user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to store_path(store_id: current_store.id)
  end

  # protected


  def after_sign_in_path_for(resource)
    store_path(store_id: current_store.id)
  end

  def after_sign_out_path_for(resource)
    store_path(store_id: current_store.id)
  end


end