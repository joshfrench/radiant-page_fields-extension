# Page Fields

Adds editable fields to your pages. These fields can be found in the "More"
drawer, along with the slug and breadcrumb. You can add, edit, and delete fields much like page parts.

## Usage

Currently, PageFields only works on edge (Radiant > 0.9.1) due to some changes
made to the core javascripts.

When you install PageFields and run the migrations, all page __keyword__ and
__description__ attributes will be converted to page fields. If you would like
your pages to be born with a different set of default fields, you may
change `Radiant::Config['defaults.page.fields']`:

    Radiant::Config['defaults.page.fields'] = 'keywords, description, author'

## Meta tags

For backwards compatibility, `r:meta`, `r:meta:description`, and
`r:meta:keywords` are retained. However, the preferred syntax is now:

    <r:meta name="keywords" />
    <r:meta name="description />"

The old tag syntax without a `name` attribute may be deprecated at some point.

## Todo

Merge in multitype support (datetime, boolean, integer fields) and
conditional tags. Document the hooks you'd want to use if you were to create
your own extended field type.