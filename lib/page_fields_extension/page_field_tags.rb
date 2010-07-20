module PageFieldsExtension::PageFieldTags
  include Radiant::Taggable

  desc %(
    Renders the content of the field given in the @name@ attribute.

    *Usage:*

    <pre><code><r:field name="Keywords" /></code></pre>
  )
  tag 'field' do |tag|
    raise TagError.new("`field' tag must contain a `name' attribute.") unless tag.attr.has_key?('name')
    tag.locals.page.fields[tag.attr['name']].try :content
  end

  desc %(
    Renders the contained elements if the field given in the @name@ attribute
    exists. The tag also takes an optional @equals@ or @matches@ attribute;
    these will expand the tag if the field's content equals or matches the
    given string or regex.

    *Usage:*

    <pre><code><r:if_field name="author" [equals|matches="John"] [ignore_case="true|false"]>...</r:if_field></code></pre>
  )
  tag 'if_field' do |tag|
    raise TagError.new("`field' tag must contain a `name' attribute.") unless tag.attr.has_key?('name')
    field = tag.locals.page.fields[tag.attr['name']]
    tag.expand if case
      when (tag.attr['equals'] and tag.attr['ignore_case'] == 'false') : field.content == tag.attr['equals']
      when tag.attr['equals'] : field.content.downcase == tag.attr['equals'].downcase
      when tag.attr['matches'] : field.content =~ build_regexp_for(tag, 'matches')
      else field
    end
  end

  desc %(
    The opposite of @if_field@. Renders the contained elements unless the field
    given in the @name@ attribute exists. The tag also takes an optional
    @equals@ or @matches@ attribute; these will expand the tag unless the
    field's content equals or matches the given string or regex.

    *Usage:*

    <pre><code><r:unless_field name="author" [equals|matches="John"] [ignore_case="true|false"]>...</r:unless_field></code></pre>
  )
  tag 'unless_field' do |tag|
    raise TagError.new("`field' tag must contain a `name' attribute.") unless tag.attr.has_key?('name')
    field = tag.locals.page.fields[tag.attr['name']]
    tag.expand unless case
      when (tag.attr['equals'] and tag.attr['ignore_case'] == 'false') : field.content == tag.attr['equals']
      when tag.attr['equals'] : field.content.downcase == tag.attr['equals'].downcase
      when tag.attr['matches'] : field.content =~ build_regexp_for(tag, 'matches')
      else field
    end
  end

end