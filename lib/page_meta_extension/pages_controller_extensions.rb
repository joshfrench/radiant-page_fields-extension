require 'admin/pages_controller'

module PageMetaExtension::PagesControllerExtensions
  def self.included(base)
    base.alias_method_chain :initialize_meta_rows_and_buttons, :page_meta
  end
  def initialize_meta_rows_and_buttons_with_page_meta
    initialize_meta_rows_and_buttons_without_page_meta
    @meta.delete_if { |m| %w(keywords description).include? m[:field] }
  end
end