
library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(DT)
library(shinycssloaders)
library(uklr)

# Define UI for app that draws a histogram ----
ui <- fluidPage(

  tags$head(
    tags$style(
      type='text/css',
    " .btn {
        float:right !important;
      }
      a {
        color: black;
      }
      a:hover  {
        color: #B2E32A;
      }
      .tab-content {
        padding-top:30px !important;
      }
      .box-format {
        background-color: #f5f5f5;
        border: 1px solid #e3e3e3;
        border-radius: 4px;
        box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
        margin-bottom: 20px;
        padding: 20px 20px 40px 20px ;

      }
      div.dt-buttons {
        float: right;
      }
      .container-extra {
        padding:0 200px;
      }

      @media (max-width: 992px) {
        .container-extra{
          padding:0;
        }
      }
      @media (min-width: 992px) and (max-width: 1204px) {
        .container-extra{
          padding:0;
        }
      }"
    )
  ),


  div(
    class="container-fluid container-extra",
    box(
      width = 3,
      div(
        class="box-format",
        tabsetPanel(
          tabPanel(
            "UKHP",
            pickerInput(
              "hp_region",
              label = "Select Region:",
              selected = "england",
              choices = sort(ukhp_avail_regions()),
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            pickerInput(
              "hp_item",
              label = "Select Item:",
              choices = ukhp_avail_items(),
              selected = "housePriceIndex",
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            dateRangeInput(
              'hp_daterange',
              label = 'Date range input: yyyy-mm-dd',
              start = "1995-01-01", end = Sys.Date()),
            actionButton(
              inputId = "submit_hp",
              label = "Submit")
          ),
          tabPanel(
            "UKPPD",
            textInput(
              "ppd_pc",
              label = "Write Postcode:",
              value = "PL6 8RU"),
            pickerInput(
              "ppd_item",
              label = "Select Item:",
              choices = ukppd_avail_items(),
              selected = "housePriceIndex",
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            pickerInput(
              "ppd_optional_item",
              label = "Select Optional Item:",
              choices = ukppd_avail_optional_items(),
              selected = "housePriceIndex",
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            dateRangeInput(
              'ppd_daterange',
              label = 'Date range input: yyyy-mm-dd',
              start = "1995-01-01", end = Sys.Date()),
            actionButton(
              inputId = "submit_ppd",
              label = "Submit")
          ),
          tabPanel(
            "UKTRANS",
            pickerInput(
              "trans",
              label = "Select Transaction:",
              choices = uktrans_avail_items(),
              selected = "totalApplicationCountByRegion",
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            pickerInput(
              "trans_region",
              label = "Select Region:",
              choices = uktrans_avail_regions(),
              options = list(
                liveSearch = TRUE,
                `actions-box` = TRUE,
                `count-selected-text` = "{0} models choosed (on a total of {1})"),
              multiple = T),
            dateRangeInput(
              'trans_daterange',
              label = 'Date range input: yyyy-mm-dd',
              start = "1995-01-01", end = Sys.Date()),
            actionButton(
              inputId = "submit_trans",
              label = "Submit")
          )
        )
      )
    ),

    box(
      width = 6,
      # withSpinner(
        DT::DTOutput(outputId = "tbl")
        # type = 3,
        # color = "#B2E32A",
        # color.background = "#fff")

    )
  )
)





# )
# ),
# selectizeInput(
#   'region', 'Select Region:', choices = ukhp_avail_regions(),
#   options = list(create = TRUE, placeholder = 'select a region'), multiple = TRUE
# ),
# Input: Slider for the number of bins ----
# sliderInput(inputId = "bins",
#             label = "Number of bins:",
#             max = 1,
#             max = 50,
#             value = 30)
