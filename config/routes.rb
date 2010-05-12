ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.page_metas 'pages/meta', :action => :create, :controller => 'page_metas', :conditions => { :method => :post }
  end
end