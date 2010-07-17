# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class PageMetaExtension < Radiant::Extension
  version "0.1"
  description "Adds editable page attributes."
  url "http://github.com/joshfrench/radiant-page_meta-extension"

  extension_config do |config|
    config.after_initialize do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.uncountable 'page_meta', 'pagemeta'
      end
    end
  end
  
  def activate
    Page.send :include, PageExtensions, MetaTags
    Admin::PagesController.send :include, PagesControllerExtensions
    admin.pages.edit.add :popups, 'add_meta_popup'
    admin.page.edit.add :extended_metadata, "page_meta"
  end

end
