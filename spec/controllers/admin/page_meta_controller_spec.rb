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

  it "should render the page_meta partial" do
    xhr :post, :create, :page_meta => { :name => "Keywords" }
    response.should render_template('admin/page_meta/_page_meta')
  end

  it "should create a model of the given class" do
    xhr :post, :create, :page_meta => {:name => 'True?', :page_meta_type => 'BooleanPageMeta'}
    assigns(:page_meta).should be_kind_of(BooleanPageMeta)
  end

end
