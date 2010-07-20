require 'admin/pages_controller'

module PageFieldsExtension::PagesControllerExtensions
  def self.included(base)
    base.alias_method_chain :initialize_meta_rows_and_buttons, :page_fields
  end
  def initialize_meta_rows_and_buttons_with_page_fields
    initialize_meta_rows_and_buttons_without_page_fields
    @meta.delete_if { |m| %w(keywords description).include? m[:field] }
  end
end