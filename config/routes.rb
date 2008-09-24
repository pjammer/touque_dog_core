ActionController::Routing::Routes.draw do |map|
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
  map.resources :search, :collection => {:search => :any}
  map.root :controller => 'site', :action => 'index'
  map.namespace :admin do |admin|
    admin.resources :adverts
    admin.resources :users, :member => { :suspend   => :put,
                                       :unsuspend => :put,
                                       :purge     => :delete }
  end
  map.resources :users
  map.resource :session
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'

  # Install the default routes as the lowest priority.
  map.connect 'profile/:login', :controller => 'profile', :action => 'show'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
