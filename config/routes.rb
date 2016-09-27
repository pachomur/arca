Rails.application.routes.draw do

  get 'application/tableau'

  resources :datosbasicos

  resources :places

  resources :cities

  devise_for :users

  resources :users_admin, :controller => 'users'

  authenticate :user do
    get 'application/admin'
    get 'artworks/admin'

    resources :iconographic_attributes

    resources :artwork_symbols

    resources :phylactery_billboards

    resources :engravings

    resources :descriptions

    resources :body_gestures

    resources :schools

    resources :story_types

    resources :passages

    resources :characters

    resources :donors

    resources :scenes

    resources :sources

    resources :types

    resources :countries

    resources :authors

    put 'artworks/send_image'

    resources :categories do
      get 'get_children_for_select', :on => :member
    end

    resources :artworks, except: [:index, :show]

  end

  resources :artworks do
    member do
      get 'line'
    end
    resources :categories
  end

  get 'welcome/index'
  #get 'application/timeline'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'


  # Example of regular route:
  #get 'index' => '#'

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
