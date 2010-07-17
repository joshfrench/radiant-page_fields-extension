require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PageMetaController do
  dataset :users

  before do
    login_as :admin
  end

  it "should assign a PageMeta object" do
    xhr :post, :create, :page_meta => {:name => "Keywords"}
    meta = assigns(:page_meta)
    meta.should be_kind_of(PageMeta)
    meta.name.should eql('Keywords')
  end

end
