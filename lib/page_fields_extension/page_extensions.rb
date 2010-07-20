module PageFieldsExtension::PageExtensions
  def self.included(base)
    base.instance_eval do
      has_many :fields, :class_name => 'PageField', :order => :id, :dependent => :destroy do
        def [](name)
          detect { |m| m.name.downcase == name.downcase }
        end
      end
      accepts_nested_attributes_for :fields, :allow_destroy => true
      class << self
        def new_with_defaults_with_fields(config = Radiant::Config)
          page = new_with_defaults_without_fields(config)
          page.fields.concat default_page_fields(config)
          page
        end
        alias_method_chain :new_with_defaults, :fields

        private

          def default_page_fields(config = Radiant::Config)
            default_fields = config['defaults.page.fields'].to_s.strip.split(/\s*,\s*/)
            default_fields.map do |name|
              PageField.new(:name => name)
            end
          end

      end
    end
  end
end