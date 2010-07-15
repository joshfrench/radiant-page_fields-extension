require File.dirname(__FILE__) + '/../spec_helper'

describe PageMetaExtension::MetaTags do

  before do
    @page = Page.new(:slug => "/", :parent_id => nil, :title => 'Home')
    @keywords = PageMeta.new(:name => 'Keywords', :content => "Home, Page")
    @description = PageMeta.new(:name => 'Description', :content => 'The homepage')
    @escaped_keywords = PageMeta.new(:name => 'Keywords', :content => "sweet & harmonious biscuits")
    @escaped_description = PageMeta.new(:name => 'Description', :content => 'sweet & harmonious biscuits')
  end

  describe "<r:meta>" do
    it "should render <meta> tags for the description and keywords" do
      @page.meta = [@keywords, @description]
      @page.should render('<r:meta/>').as(%{<meta name="description" content="The homepage" /><meta name="keywords" content="Home, Page" />})
    end

    it "should render <meta> tags with escaped values for the description and keywords" do
      @page.meta = [@escaped_keywords, @escaped_description]
      @page.should render('<r:meta/>').as(%{<meta name="description" content="sweet &amp; harmonious biscuits" /><meta name="keywords" content="sweet &amp; harmonious biscuits" />})
    end

    it "should render <meta> tag for named attribute" do
      @page.meta = [@keywords, @description]
      @page.should render('<r:meta name="description"/>').as(%{<meta name="description" content="The homepage" />})
    end

    describe "with 'tag' attribute set to 'false'" do
      it "should render the contents of the description and keywords" do
        @page.meta = [@keywords, @description]
        @page.should render('<r:meta tag="false" />').as(%{The homepageHome, Page})
      end

      it "should escape the contents of the description and keywords" do
        @page.meta = [@escaped_keywords, @escaped_description]
        @page.should render('<r:meta tag="false" />').as("sweet &amp; harmonious biscuitssweet &amp; harmonious biscuits")
      end

      it "should render <meta> tag for named attribute" do
        @page.meta = [@keywords, @description]
        @page.should render('<r:meta name="description" tag="false"/>').as('The homepage')
      end
    end
  end

  describe "<r:meta:description>" do
    it "should render a <meta> tag for the description" do
      @page.meta = [@keywords, @description]
      @page.should render('<r:meta:description/>').as(%{<meta name="description" content="The homepage" />})
    end

    it "should render a <meta> tag with escaped value for the description" do
      @page.meta = [@escaped_keywords, @escaped_description]
      @page.should render('<r:meta:description />').as(%{<meta name="description" content="sweet &amp; harmonious biscuits" />})
    end

    describe "with 'tag' attribute set to 'false'" do
      it "should render the contents of the description" do
        @page.meta = [@keywords, @description]
        @page.should render('<r:meta:description tag="false" />').as(%{The homepage})
      end

      it "should escape the contents of the description" do
        @page.meta = [@escaped_keywords, @escaped_description]
        @page.should render('<r:meta:description tag="false" />').as("sweet &amp; harmonious biscuits")
      end
    end
  end

  describe "<r:meta:keywords>" do
    it "should render a <meta> tag for the keywords" do
      @page.meta = [@keywords, @description]
      @page.should render('<r:meta:keywords/>').as(%{<meta name="keywords" content="Home, Page" />})
    end

    it "should render a <meta> tag with escaped value for the keywords" do
      @page.meta = [@escaped_keywords, @escaped_description]
      @page.should render('<r:meta:keywords />').as(%{<meta name="keywords" content="sweet &amp; harmonious biscuits" />})
    end

    describe "with 'tag' attribute set to 'false'" do
      it "should render the contents of the keywords" do
        @page.meta = [@keywords, @description]
        @page.should render('<r:meta:keywords tag="false" />').as(%{Home, Page})
      end

      it "should escape the contents of the keywords" do
        @page.meta = [@escaped_keywords, @escaped_description]
        @page.should render('<r:meta:keywords tag="false" />').as("sweet &amp; harmonious biscuits")
      end
    end
  end

  describe "#meta_tag_for" do
    it "should return standard tag" do
      @page.meta_tag_for(PageMeta.new).should eql('meta:string')
    end

    it "should return a defined subclass" do
      @page.meta_tag_for(DatetimePageMeta.new).should eql('meta:datetime')
    end

    it "should default to base if no subclass tag is defined" do
      @page.meta_tag_for(IntegerPageMeta.new).should eql('meta:string')
    end
  end

  describe "Meta tag delegation" do
    it "should render an Integer meta as a string" do
      @page.meta = [IntegerPageMeta.new(:name => 'int', :content => 100)]
      @page.should render('<r:meta name="int" tag="false" />').as('100')
    end

    describe "r:meta:boolean" do
      it "should render 'true'" do
        @page.meta = [BooleanPageMeta.new(:name => 'bool', :content => true)]
        @page.should render('<r:meta name="bool" tag="false" />').as('true')
      end
    end

    describe "r:meta:datetime" do
      before do
        @time = Time.now
        @page.meta = [DatetimePageMeta.new(:name => 'expires-on', :content => @time)]
      end

      it "should render the meta content" do
        @page.should render('<r:meta name="expires-on" />').matching(%r[#{@time.strftime("%A, %B %d, %Y")}])
      end

      it "should take a format attr" do
        @page.should render('<r:meta name="expires-on" format="%X" />').matching(%r[#{@time.strftime("%X")}])
      end
    end
  end

  context "Boolean tags r:meta" do
    before do
      @bool = BooleanPageMeta.new(:name => 'bool', :content => true)
      @page.meta = [@bool]
    end

    describe ":if" do
      it "should expand if true" do
        @page.should render('<r:meta:if name="bool">T</r:meta:if>').as('T')
      end

      it "should not expand if false" do
        @bool.content = false
        @page.should render('<r:meta:if name="bool">F</r:meta:if>').as('')
      end
    end

    describe ":unless" do
      it "should not expand if true" do
        @page.should render('<r:meta:unless name="bool">T</r:meta:unless>').as('')
      end

      it "should expand if false" do
        @bool.content = false
        @page.should render('<r:meta:unless name="bool">F</r:meta:unless>').as('F')
      end
    end
  end

end