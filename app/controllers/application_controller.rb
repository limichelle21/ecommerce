class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  before_filter :find_store


  	# do I need to create a "store" model? 
  	# a Store would have a slug, and a subdomain belongs to slug.ecommerce.com
  	# what does it mean to whitelist_subdomain?




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
