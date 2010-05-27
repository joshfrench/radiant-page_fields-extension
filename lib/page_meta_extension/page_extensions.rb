module PageMetaExtension::PageExtensions
  def self.included(base)
    base.instance_eval do
      has_many :metas, :class_name => 'PageMeta', :order => :id, :dependent => :destroy do
        def [](name)
          detect { |m| m.name.downcase == name.downcase }.try :content
        end
      end
      accepts_nested_attributes_for :metas, :allow_destroy => true
      class << self
        def new_with_defaults_with_meta(config = Radiant::Config)
          page = new_with_defaults_without_meta(config)
          page.metas.concat default_page_meta(config)
          page
        end
        alias_method_chain :new_with_defaults, :meta

        private

          def default_page_meta(config = Radiant::Config)
            default_meta = config['defaults.page.meta'].to_s.strip.split(/\s*,\s*/)
            default_meta.map do |name|
              PageMeta.new(:name => name)
            end
          end

      end
    end
  end
end