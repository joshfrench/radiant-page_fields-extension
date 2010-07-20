require_dependency 'application_controller'

class PageFieldsExtension < Radiant::Extension
  version "0.1"
  description "Adds editable page fields."
  url "http://github.com/joshfrench/radiant-page_fields-extension"
  
  def activate
    Page.send :include, PageExtensions, PageFieldTags, DeprecatedMetaTags
    Admin::PagesController.send :include, PagesControllerExtensions
    admin.pages.edit.add :popups, 'add_field_popup'
    admin.page.edit.add :extended_metadata, "page_fields"
  end

end
