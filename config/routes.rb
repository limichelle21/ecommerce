Rails.application.routes.draw do

  get 'carts/show'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :dashboard do 
    resources :stores, only: [:new, :create, :show, :update] do
      resources :products
      resources :orders, only: [:index, :show, :update, :destroy]
      resources :order_lines, only: [:index, :show, :update, :destroy]
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get ':id', to: 'stores#show' # ecommerce.com/matts-store

  root 'welcome#index'

  resources :stores, only: [:show], path: '/' do 
    resource :cart, only: [:show]
    resources :products, only: [:index, :show]
    resources :orders, only: [:index, :show] 
    resources :order_lines, only: [:create, :update, :destroy]
  end   


    # ecommerce.com/matts-store/products
    # ecommerce.com/matts-store/cart
    # ecommerce.com/matts-store/checkout
    # ecommerce.com/matts-store/orders/1  - history


# class CustomDomainConstraint

#   def store.matches?(request)
#     matching_store?(request)
#   end

#   def self.matching_store?(request)
#     if request.subdomain == 'www'
#       req = request.host[4..-1]
#     else
#       req = request.host
#     end

#     Store.where(:domain => req).any? || Store.where(:slug => request.subdomain).any?
#   end
# end


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
