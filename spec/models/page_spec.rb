require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  it "should allow initialization with default meta" do
    @page = Page.new_with_defaults({ 'defaults.page.meta' => 'x, y, z' })
    @page.metas.size.should == 3
    @page.metas.first.name.should == 'x'
    @page.metas.last.name.should == 'z'
  end
end