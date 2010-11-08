# Page Fields

Adds editable fields to your pages. These fields can be found in the "More"
drawer, along with the slug and breadcrumb. You can add, edit, and delete fields
much like page parts.

## Usage

PageFields is now a part of Radiant core. It was merged in some time after
0.9.1, and is not compatible with Radiant 0.9.1 or earlier. This means you
probably don't need to install PageFields unless you are running a specific
checkout of Radiant in a narrow range between 0.9.1 and the current edge.

If you want your pages to be born with a different set of default fields, you may
change `Radiant::Config['defaults.page.fields']`:

    Radiant::Config['defaults.page.fields'] = 'keywords, description, author'

To output data to your pages use:
    <r:field name="field_name" />

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
