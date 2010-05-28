ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.page_meta 'pages/meta', :action => :create, :controller => 'page_meta', :conditions => { :method => :post }
  end
end