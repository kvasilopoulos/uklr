# uklr 1.0.2

# `uktrans_get` is fixed when start_date is used (#2)
# Extra layer of of NULL returns to fail gracefully with an informative message.
# Removed travis & appveyor and using gh_actions instead.
# Using gh-pages to create the pkgdown website.
# Create an app as vignette page to search with the help of uklr.

# uklr 1.0.1

## Fixed Bugs

* Fixed `ukppd_get()` when choosing `item` and optional `item arguments`
* `ukppd_avail_postcodes()` now returns available postcodes in england and wales

## Functions

* Function `get_query()` has been renamed to `retrieve_query()`
* `get_query()` returns formatted `sparql` query
* The `ukppd_get()` item returns the whole URI and now will only return the info needed. For example for `item=propertyType` it would return the whole URI `http://landregistry.data.gov.uk/def/common/semi-detached` while now just `semi-detahed`.


# uklr 1.0.0

* Added a `NEWS.md` file to track changes to the package.
