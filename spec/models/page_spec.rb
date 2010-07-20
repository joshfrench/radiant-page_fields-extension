require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  it "should allow initialization with default fields" do
    @page = Page.new_with_defaults({ 'defaults.page.fields' => 'x, y, z' })
    @page.fields.size.should == 3
    @page.fields.first.name.should == 'x'
    @page.fields.last.name.should == 'z'
  end

  describe "#fields[]" do
    before do
      @page = Page.new
      @page.fields << PageField.new(:name => 'Field', :content => 'sweet harmonious biscuit')
    end

    it "should find field by name" do
      @page.fields['Field'].content.should eql('sweet harmonious biscuit')
    end

    it "should be case insensitive" do
      @page.fields['Field'].content.should eql('sweet harmonious biscuit')
    end

    it "should return nil if meta not found" do
      @page.fields['Bogus'].should be_nil
    end
  end
end