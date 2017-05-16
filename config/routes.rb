Rails.application.routes.draw do


  scope '/dashboard' do 
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
  end 

  scope '/:store_id' do
    devise_for :customers, controllers: {
      registrations: 'customers/registrations',
      sessions: 'customers/sessions'
    }
  end

  namespace :dashboard do 
      root 'products#index'
      resources :stores, only: [:new, :create, :edit, :update], path: '/' do 
        resources :products
        resources :orders, only: [:index, :show, :destroy]
        resources :order_lines, only: [:index, :show]
        resources :customers, only: [:index]
      end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   
  # ecommerce.com/matts-store

  #   get 'products/:id' => 'catalog#view'

  root 'welcome#index'

  get ':store_id', to: 'stores#show', as: 'store'
  resources :stores, only: [:show], path: '/' do 
    # resources :users, only: [:new]
    # get '/users/sign_up' => 'customers#new', as: 'sign_up'
    # post '/users/sign_up' => 'customers#create', as: 'user_sign_up'
    # get '/users/sign_in' => 'sessions#new', as: 'sign_in'
    # post '/users/sign_in' => 'sessions#create'
    # delete '/users/sign_out' => 'sessions#destroy', as: 'sign_out'
    resource :cart, only: [:show]
    resources :products, only: [:index, :show]
    resources :orders, only: [:index, :show]
    get '/orders/:id/confirmation' => 'orders#confirmation', as: 'confirmation'
    resources :order_lines, only: [:create, :update, :destroy]
    resources :charges, only: [:new, :create]
  end   



# path: '/'

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
