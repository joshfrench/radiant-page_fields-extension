require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagesController do
  dataset :users
  describe "initialize_meta_rows_and_buttons" do
    it "should not contain keywords or description" do
      login_as :admin
      get :new
      assigns(:meta).select{ |m| %w(keywords description).include?(m[:field]) }.should be_empty
    end
  end
end