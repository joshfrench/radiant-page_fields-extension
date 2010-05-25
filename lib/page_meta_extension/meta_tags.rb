module PageMetaExtension::MetaTags
  include Radiant::Taggable

  desc %{
    The namespace for 'meta' attributes.  If used as a singleton tag, both the description
    and keywords fields will be output as &lt;meta /&gt; tags unless the attribute 'tag' is set to 'false'.

    *Usage:*

    <pre><code> <r:meta [tag="false"] />
     <r:meta>
       <r:description [tag="false"] />
       <r:keywords [tag="false"] />
     </r:meta>
    </code></pre>
  }
  tag 'meta' do |tag|
    if tag.double?
      tag.expand
    else
      tag.render('description', tag.attr) +
      tag.render('keywords', tag.attr)
    end
  end

  desc %{
    Emits the page description field in a meta tag, unless attribute
    'tag' is set to 'false'.

    *Usage:*

    <pre><code> <r:meta:description [tag="false"] /> </code></pre>
  }
  tag 'meta:description' do |tag|
    show_tag = tag.attr['tag'] != 'false' || false
    description = CGI.escapeHTML(tag.locals.page.description)
    if show_tag
      "<meta name=\"description\" content=\"#{description}\" />"
    else
      description
    end
  end

  desc %{
    Emits the page keywords field in a meta tag, unless attribute
    'tag' is set to 'false'.

    *Usage:*

    <pre><code> <r:meta:keywords [tag="false"] /> </code></pre>
  }
  tag 'meta:keywords' do |tag|
    show_tag = tag.attr['tag'] != 'false' || false
    keywords = CGI.escapeHTML(tag.locals.page.keywords)
    if show_tag
      "<meta name=\"keywords\" content=\"#{keywords}\" />"
    else
      keywords
    end
  end
end