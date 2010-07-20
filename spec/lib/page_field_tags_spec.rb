require File.dirname(__FILE__) + '/../spec_helper'

describe PageFieldsExtension::PageFieldTags do
  before do
    @page = Page.new(:slug => "/", :parent_id => nil, :title => 'Home')
    @field = PageField.new(:name => 'Field', :content => "Sweet harmonious biscuits")
    @page.fields = [@field]
  end

  describe '<r:field>' do
    it "should return field content" do
      @page.should render('<r:field name="field" />').as('Sweet harmonious biscuits')
    end

    it "should do nothing for missing field" do
      @page.should render('<r:field name="bogus" />').as('')
    end
  end

  describe "<r:if_field>" do
    describe "with `name` attr" do
      it "should should expand if field exists" do
        @page.should render('<r:if_field name="field">Ok</r:if_field>').as('Ok')
      end
    end

    describe "with `equals` attr" do
      it "should expand if content equals attr" do
        @page.should render('<r:if_field name="field" equals="sweet harmonious biscuits">Ok</r:if_field>').as('Ok')
      end

      it "should be case sensitive if ignore_case is false" do
        @page.should render('<r:if_field name="field" equals="sweet harmonious biscuits" ignore_case="false">Ok</r:if_field>').as('')
      end
    end

    describe "with `matches` attr" do
      it "should expand if content matches attr" do
        @page.should render('<r:if_field name="field" matches="^sweet\s">Ok</r:if_field>').as('Ok')
      end

      it "should be case sensitive if ignore_case is false" do
        @page.should render('<r:if_field name="field" matches="^sweet\s" ignore_case="false">Ok</r:if_field>').as('')
      end
    end
  end

  describe "<r:unless_field>" do
    describe "with `name` attr" do
      it "should should expand unless field exists" do
        @page.should render('<r:unless_field name="field">Ok</r:unless_field>').as('')
      end

      it "should not expand if field exists" do
        @page.should render('<r:unless_field name="bogus">Ok</r:unless_field>').as('Ok')
      end
    end

    describe "with `equals` attr" do
      it "should expand unless content equals attr" do
        @page.should render('<r:unless_field name="field" equals="sweet harmonious biscuits">Ok</r:unless_field>').as('')
      end

      it "should be case sensitive if ignore_case is false" do
        @page.should render('<r:unless_field name="field" equals="sweet harmonious biscuits" ignore_case="false">Ok</r:unless_field>').as('Ok')
      end
    end

    describe "with `matches` attr" do
      it "should expand unless content matches attr" do
        @page.should render('<r:unless_field name="field" matches="^sweet\s">Ok</r:unless_field>').as('')
      end

      it "should be case sensitive if ignore_case is false" do
        @page.should render('<r:unless_field name="field" matches="^sweet\s" ignore_case="false">Ok</r:unless_field>').as('Ok')
      end
    end
  end

end