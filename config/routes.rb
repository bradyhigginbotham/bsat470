Bsat470::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :employees, ActiveAdmin::Devise.config

	resources :clients do
    get :ajax_call, :on => :collection
    get :next_id, :on => :collection
  end

	resources :work_orders do
    get :get_location, :on => :collection
  end

	resources :locations do
    get :list, :on => :collection
    get :ajax_call, :on => :collection
  end

	resources :tasks do
    get :ajax_call, :on => :collection
    get :assignments_ajax_call, :on => :collection
  end

  resources :assignments do
    get :ajax_materials, :on => :collection
    get :ajax_labor, :on => :collection
  end

  resources :proposals,
            :materials,
            :material_assignments,
            :labor_assignments

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
