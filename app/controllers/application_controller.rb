class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  # before_action :redirect_dashboard

  before_filter :find_store

  def current_order
    @current_order ||= session[:current_order_id] && Order.find_by(id: session[:current_order_id])
  end

  helper_method :current_order


  # def redirect_dashboard
  #   redirect_to dashboard_store_path if current_user.owner? 
  # end
  # checks current_user login type. If owner, redirect to dashboard paths
  # why is owner? not recognized as a method if in the User model?


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



end