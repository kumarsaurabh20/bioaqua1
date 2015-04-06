Bioaqua1::Application.routes.draw do

  resources :microposts
  resources :data_gprs
  resources :batch_images
  resources :batch_samplings
  resources :batch_oligos
  resources :microarraygprs
  resources :gpr_headers
  resources :gpr_data
  resources :nucleic_acids
  resources :nucleic_acid_types
  resources :filter_sample_preparations
  resources :sampling_equipments
  resources :geos
  resources :size_typologies
  resources :depths
  resources :geologies
  resources :catchment_areas
  resources :altitude_types
  resources :micro_arrays
  resources :microarraygals
  resources :gal_headers
  resources :gal_blocks
  resources :oligos
  resources :experiments
  resources :micro_array_images
  resources :micro_array_analysis_files
  resources :micro_array_validations
  resources :micro_array_datas
  resources :names
  resources :oligo_sequences
  match '/lookforbio' => 'oligo_sequences#lookup', :as => :lookforbio
  match '/searchforbio' => 'oligo_sequences#esearch', :as => :searchforbio
  resources :nodes
  resources :countries
  resources :wfilters
  resources :samplings
  resources :meteorological_datas
  resources :microposts
  resources :users
  match '/signup' => 'users#new', :as => :signup
  resources :sessions, :only => [:new, :create, :destroy]
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  resources :operations
  resources :protocols
  resources :land_use_mappings
  resources :partner_people
  resources :partners
  resources :people
  resources :geos
  resources :code_types
  resources :water_types
  resources :water_uses
  resources :posts
  resources :sampling_sites
  resources :filter_samples
  match '/contact' => 'pages#contact', :as => :contact
  match '/about' => 'pages#about', :as => :about
  match '/help' => 'pages#help', :as => :help

  root :to => "home#index"
  #added the above otherwise getting undefined variable root_path

  match '/' => 'home#index'
  match '/:controller(/:action(/:id))'
  match ':controller/:action.:format' => '#index'
  match '/export_all' => 'oligo_sequences#export_all'
  match '/download_sample_csv' => 'batch_oligos#download_sample_csv'
  match '/download_sample_sampling_csv' => 'batch_samplings#download_sample_sampling_csv'
  match '/export_to_csv' => 'oligo_sequences#export_to_csv'
  match '/export_all_xls.xls' => 'oligo_sequences#export_all_xls'
  match '/analyze_experiment' => 'experiments#analyze_experiment', via: [:get, :post]




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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
