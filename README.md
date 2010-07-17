# Page Meta

PageMeta adds editable attributes to your pages. These attributes can be found
in the "More" drawer, along with the slug and breadcrumb. You can add, edit,
and delete attributes much like page parts.

## Usage

When you install PageMeta and run the migrations, the __keyword__ and
__description__ fields will be converted to page attributes. If you would like
your pages to be born with a different set of default attributes, you may
change `Radiant::Config['defaults.page.meta']`:

    Radiant::Config['defaults.page.meta'] = 'keywords, description, author'

## Meta tags

For backwards compatibility, `r:meta`, `r:meta:description`, and
`r:meta:keywords` are retained. However, the preferred syntax is now:

    <r:meta name="keywords" />
    <r:meta name="description />"

The old tag syntax without a `name` attribute may be deprecated at some point.