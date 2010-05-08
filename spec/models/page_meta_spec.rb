require File.dirname(__FILE__) + '/../spec_helper'

describe PageMeta do
  before(:each) do
    @page_meta = PageMeta.new
  end

  it "should be valid" do
    @page_meta.should be_valid
  end
end
