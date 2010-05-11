ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :meta, :only => [:new, :create], :path_prefix => 'pages'
  end
end