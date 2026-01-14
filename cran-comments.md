## Release summary

This is a bug fix release that addresses two user-reported issues:

* Fixed single-row transaction result handling (issue #5)
* Renamed dataset `pc` to `uklr_pc` to avoid naming conflicts with user variables (issue #4)

## Test environments

* local Windows install, R 4.3.2
* GitHub Actions (via r-lib/actions/examples@v2):
  * macOS-latest (R-release)
  * windows-latest (R-release)
  * ubuntu-latest (R-devel, R-release, R-oldrel-1)
* win-builder (R-devel and R-release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

There are currently no downstream dependencies for this package.

## Breaking changes

* Dataset `pc` has been renamed to `uklr_pc`. This is a breaking change for code that directly accesses the dataset, but function interfaces remain unchanged.
