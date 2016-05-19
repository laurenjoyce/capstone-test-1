Rails.application.routes.draw do
  devise_for :users
#  resources :posts

  get '/' => 'doctors#index'
  get '/doctors/:id' => 'doctors#show'

  get '/saved_doctors' => 'saved_doctors#index'
  post '/saved_doctors' => 'saved_doctors#create'
  get '/saved_doctors/:id' => 'saved_doctors#show'
  delete '/saved_doctors' => 'saved_doctors#destroy'

  get '/questions' => 'questions#index'
  post '/questions' => 'questions#create'

  get '/reviews' => 'reviews#index'
  post '/reviews' => 'reviews#create'

  get '/user_profiles' => 'user_profiles#index'
  post '/user_profiles' => 'user_profiles#create'
  get '/user_profiles/edit' => 'user_profiles#edit'
  patch '/user_profiles' => 'user_profiles#update'

  get '/posts' => 'posts#index'
  get '/posts/new' => 'posts#new'
  post '/posts' => 'posts#create'
  get '/posts/:id' => 'posts#show'
  get '/posts/:id/edit' => 'posts#edit'
  patch '/posts/:id' => 'posts#update'
  delete '/posts/:id' => 'posts#destroy'

  namespace :api do
    namespace :v1 do
      post '/geolocation' => 'geolocation#set_cookie'
    end
  end

  # post '/search' => 'doctors#run_search'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
