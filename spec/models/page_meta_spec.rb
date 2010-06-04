require File.dirname(__FILE__) + '/../spec_helper'

describe PageMeta do
  describe ".new" do
    it "should cast instance to subclass if type is given" do
      meta = PageMeta.new(:page_meta_type => 'BooleanPageMeta')
      meta.class.should be(BooleanPageMeta)
    end

    it "should use parent class if type is omitted" do
      meta = PageMeta.new
      meta.class.should be(PageMeta)
    end

    it "should use parent class if type is a mismatch" do
      meta = PageMeta.new(:page_meta_type => 'Page')
      meta.class.should be(PageMeta)
    end
  end
end
