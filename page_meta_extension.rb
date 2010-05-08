# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class PageMetaExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://github.com/jfrench/radiant-page_meta-extension"

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    Page.send :include, PageExtensions
  end
end