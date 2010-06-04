class PageMeta < ActiveRecord::Base
  set_inheritance_column :page_meta_type
  validates_presence_of :name

  class << self
    ##
    # @param [Hash] attributes Normal ActiveRecord attrs hash
    # @option attributes [String] :page_meta_type
    #   Pass :page_meta_type => 'PageMetaDescendant' to return an object of the
    #   given subclass.
    # @example
    #   meta = PageMeta.new(:page_meta_type => 'BooleanPageMeta')
    #   meta.class #=> BooleanPageMeta
    def new(attributes={})
      attributes.stringify_keys!
      if klass_name = attributes.delete('page_meta_type') and (klass = klass_name.constantize) < PageMeta
        klass.new(attributes)
      else
        super
      end
    end
  end

end
