require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PageMetasController do
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

  it "should render the meta_row partial" do
    xhr :post, :create
    response.should render_template('admin/page_metas/_page_meta')
  end

end
