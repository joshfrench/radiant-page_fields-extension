ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.page_fields 'pages/fields', :action => :create, :controller => 'page_fields', :conditions => { :method => :post }
  end
end