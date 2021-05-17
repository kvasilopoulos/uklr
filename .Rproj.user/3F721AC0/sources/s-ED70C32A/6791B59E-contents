build_site:
	Rscript -e "devtools::document(roclets = c('rd', 'collate', 'namespace'))"
	Rscript -e "pkgdown::build_site()"

build_manual:
	Rscript -e "devtools::build_manual"

check:
	Rscript -e "devtools::check()"

cran_check:
	Rscript -e "devtools::check_win_devel(quiet = TRUE)"
	Rscript -e "devtools::check_rhub(interactive = FALSE)"
