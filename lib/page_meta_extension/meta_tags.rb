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
      if !tag.attr['name'].blank?
        meta = tag.attr['name']
        show_tag = tag.attr['tag'] != 'false' || false
        description = CGI.escapeHTML(tag.locals.page.meta[meta])
        if show_tag
          %{<meta name="#{meta.downcase}" content="#{description}" />}
        else
          description
        end
      else
        ActiveSupport::Deprecation.warn("Using r:meta without a `name' attribute is deprecated. Please use r:meta name='Meta Attribute' instead.", caller)
        tag.render('description', tag.attr) +
        tag.render('keywords', tag.attr)
      end
    end
  end

  tag 'meta:datetime' do |tag|
  end

  def meta_tag_for(meta)
    klass = meta.class
    while klass != meta.class.base_class
      tag = klass.name.to_name('Page Meta').downcase
      return "meta:#{tag}" if respond_to?("tag:meta:#{tag}")
      klass = klass.superclass
    end
    return 'meta:string'
  end

  desc %{
    Emits the page description field in a meta tag, unless attribute
    'tag' is set to 'false'.

    *Usage:*

    <pre><code> <r:meta:description [tag="false"] /> </code></pre>
  }
  tag 'meta:description' do |tag|
    ActiveSupport::Deprecation.warn('r:meta:description is deprecated. Please use r:meta name="Description" instead.', caller)
    show_tag = tag.attr['tag'] != 'false' || false
    description = CGI.escapeHTML(tag.locals.page.meta['Description'])
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
    ActiveSupport::Deprecation.warn('r:meta:keywords is deprecated. Please use r:meta name="Keywords" instead.', caller)
    show_tag = tag.attr['tag'] != 'false' || false
    keywords = CGI.escapeHTML(tag.locals.page.meta['Keywords'])
    if show_tag
      "<meta name=\"keywords\" content=\"#{keywords}\" />"
    else
      keywords
    end
  end

end