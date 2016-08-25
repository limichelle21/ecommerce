class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  include SessionsHelper 
  
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_filter :find_store
 
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_store
  before_action :current_store

  helper_method :current_order
  before_action :current_order



  def current_order 
    if current_store.present?
      if !session["current_order_id_#{current_store.id}"].nil?
        @current_order = current_store.orders.find_by(id: session["current_order_id_#{current_store.id}"])
      else
        @current_order = current_store.orders.create
      end
    else
      nil
    end
  end

  def current_store
    @current_store = params[:store_id].present? ? Store.friendly.find(params[:store_id]) : nil
  end


  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end



  def find_store
  	whitelist_subdomains = %w(www ecommerce)
  	if request.subdomain.present? && !whitelist_subdomains.include?(request.subdomain)
  		@store =  Store.friendly.find(request.subdomain)
  	else 
  		req = request.host
  	end
  	#check if a store exists with the requested domain, then if it is a subdomain
  	# @store = Store.find_by(domain: req) || Store.find_by(slug: request.subdomain)

  	# redirect to root unless a matching store is found
  	redirect_to dashboard_root_path if @store
  end

  private

  def after_sign_out_path_for(user)
    store_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :type) }
  end



end