require File.dirname(__FILE__) + '/../spec_helper'

describe PageMetaExtension::MetaTags do
  before do
    @page = Page.new(:slug => "/", :parent_id => nil, :title => 'Home')
    # @body = PagePart.new(:name => 'body', :content => 'Hello World')
    # @page.parts << @body
    @meta = PageMeta.new :name => "Keywords", :content => "sweet, harmonious, biscuits"
  end

  it "should display a meta by name" do
    @page.should render('<r:meta name="keywords" />').as "sweet, harmonious, biscuits"
  end

  it "should return nil of no meta is found"
end