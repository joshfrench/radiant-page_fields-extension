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

  describe 'description' do
    it "should calculate subclass description" do
      class NamedPageMeta < PageMeta ; end
      NamedPageMeta.description.should eql('Named')
    end
  end

  describe ".content" do
    it "should alias content attribute" do
      meta = PageMeta.new(:content => "text", :integer_content => 123)
      meta.content.should eql('text')
      PageMeta.content = :integer
      meta.content.should eql(123)
    end

    it "should set storage column" do
      PageMeta.content = :integer
      PageMeta.content_column.should eql('integer_content')
    end
  end

  describe ".attributes=" do
    it "should ignore empty content if storage column is passed" do
      meta = IntegerPageMeta.new
      meta.attributes = { :integer_content => 1, :content => ''}
      meta.content.should eql(1)
    end
  end

  describe ".partial_name" do
    specify "base class should be string_page_meta" do
      PageMeta.partial_name.should eql('string_page_meta')
    end

    specify "subclass should be derived from class name" do
      BooleanPageMeta.partial_name.should eql('boolean_page_meta')
    end
  end

end
