class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_filter :find_store
 
  helper_method :current_order
  before_filter :current_order

  before_action :configure_permitted_parameters, if: :devise_controller?


  # def current_order_2
  #   @store = Store.friendly.find(params[:store_id])
  #   @current_order ||= session[:current_order_id] && @store.orders.find_by(id: session[:current_order_id])
  # end


  def current_order #this works
    @store = Store.friendly.find(params[:store_id])
    if !session[:current_order_id].nil?
      @store.orders.find_by(id: session[:current_order_id])
    else
      @store.orders.create
    end
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
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :type) }
  end



end