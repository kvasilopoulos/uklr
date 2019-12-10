## Test environments

* local OS X install, R 3.6.1
* Continuous Integration
  * Ubuntu Trusty 14.04 on travis-ci (devel and release)
  * macOS on travis-ci (devel and release)
  * Windows Server 2012 on appveyor (devel and release)
* Rhub
  * Debian Linux, R-devel & R-devel, GCC ASAN/UBSAN
  * Fedora Linux, R-devel & R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.


Omit the redundant "R" from the title.

Please always explain all acronyms in the description text.

Please always and only write package names, software names and API names
in single quotes in title and description.
e.g: 'uklr'

Please only capitalize sentence beginnings and names in the description
text. e.g. --> transaction data ...

Please add \value to .Rd files regarding methods and explain the
functions results in the documentation.
(See: Writing R Extensions
<https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Documenting-functions>
)
