require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  it "should allow initialization with default meta" do
    @page = Page.new_with_defaults({ 'defaults.page.meta' => 'x, y, z' })
    @page.meta.size.should == 3
    @page.meta.first.name.should == 'x'
    @page.meta.last.name.should == 'z'
  end

  describe "#meta[]" do
    before do
      @page = Page.new
      @page.meta << PageMeta.new(:name => 'Meta', :content => 'sweet harmonious biscuit')
    end

    it "should find meta by name" do
      @page.meta['Meta'].should eql('sweet harmonious biscuit')
    end

    it "should be case insensitive" do
      @page.meta['meta'].should eql('sweet harmonious biscuit')
    end

    it "should return nil if meta not found" do
      @page.meta['Bogus'].should be_nil
    end
  end
end