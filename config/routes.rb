Rails.application.routes.draw do  

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :projects do 
    collection do 
      get 'analytics'
    end
  end

  resources :project_managers, :only => [] do
    member do 
      get 'edit_developer'
      delete 'delete_developer'
    end
    collection do
      get 'add_developer'
      post 'create_developer' 
      post 'update_developer'     
    end
  end

  get 'developers/index'

  resources :developers, :only => [:index] do    
    member do
      get 'change_status_to_done'      
      get 'change_status_to_in_progress'
    end
  end

  devise_for :users, :controllers => { :registrations => :registrations }
  # get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"  

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
