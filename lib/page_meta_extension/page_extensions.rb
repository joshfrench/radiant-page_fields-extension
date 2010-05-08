module PageMetaExtension::PageExtensions
  def self.included(base)
    base.instance_eval do
      has_many :metas, :class_name => 'PageMeta', :order => :id, :dependent => :destroy
      accepts_nested_attributes_for :metas, :allow_destroy => true
    end
  end
end