ActionController::Routing::Routes.draw do |map|
  map.resources :glogs do |glog|
    glog.resources :goals, :path_prefix => "glog/:login"
  end

  map.resources :prategories
  map.resources :profiles, :path_prefix => "profile/:login" do |profile|
    profile.resources :photos, :member => { :select => :post, :deselect => :post }, :path_prefix => "profile/:login" 
    profile.resources :notes, :path_prefix => "profile/:login"
    profile.resources :emails, :path_prefix => "profile/:login",
                        :collection => {:destroy_selected => :post,
                                        :inbox            => :get,
                                        :outbox           => :get,
                                        :trashbin         => :get},
                        :member     => {:reply => :get}
  end

 
  map.resources :products, :has_many => :reviews
  map.resources :search, :collection => {:search => :any}
  map.resources :topics, :member => { :show_new => :get }
  map.resources :messages, :member => { :quote => :get, :topic => :get }
  map.resources :forums
  map.resources :categories
  map.resources :rating, :member => {:rate => :post}
  map.root :controller => 'site', :action => 'index'
  
  
  map.namespace :admin do |admin|
    admin.resources :posts
    admin.resources :categories
    admin.resources :forums
    admin.resources :products
    admin.resources :adverts
    admin.resources :prategories
    admin.resources :users, :member => { :suspend   => :put,
                                       :unsuspend => :put,
                                       :purge     => :delete }
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  map.resources :users
  map.resource :session
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'

  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.

  
  map.connect 'profile/:login', :controller => 'profile', :action => 'show'
  map.connect 'glog/:login/goals', :controller => 'goals', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
