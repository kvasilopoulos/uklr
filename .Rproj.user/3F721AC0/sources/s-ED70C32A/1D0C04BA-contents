# Define server logic required to draw a histogram ----
server <- function(input, output) {


  tbl_hp_srv <- reactive({
    validate(
      need(input$hp_region != "", "Please select a region.")
    )

    ukhp_get(
      input$hp_region,
      item = input$hp_item,
      start_date = input$hp_daterange[1],
      end_date = input$hp_daterange[2])
  })
  tbl_ppd_srv <- reactive({
    validate(
      need(input$ppd_pc != "", "Please select a pc.")
    )
    ukppd_get(
      input$ppd_pc,
      item = input$ppd_item,
      optional_item = input$ppd_optional_item,
      start_date = input$ppd_daterange[1],
      end_date = input$ppd_daterange[2]
    )
  })
  tbl_trans_srv <- reactive({
    validate(
      need(input$trans != "", "Please select an item.")
    )
    uktrans_get(
      item = input$trans,
      region = input$trans_region,
      start_date = input$trans_daterange[1],
      end_date = input$trans_daterange[2]
    )
  })

  observeEvent(input$submit_hp,{
    output$tbl <- DT::renderDT(
      server = FALSE,
      DT::datatable(
        tbl_hp_srv(),
        rownames = FALSE,
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          searching = FALSE,
          # autoWidth = TRUE,
          paging = TRUE,
          lengthChange = FALSE,
          pageLength = 20,
          # scrollX = T,
          buttons = specify_buttons("uklr")
        )
      )
    )
  })
  observeEvent(input$submit_ppd,{
    output$tbl <- DT::renderDT(
      server = FALSE,
      DT::datatable(
        tbl_ppd_srv(),
        rownames = FALSE,
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          searching = FALSE,
          # autoWidth = TRUE,
          paging = TRUE,
          lengthChange = FALSE,
          pageLength = 20,
          # scrollX = T,
          buttons = specify_buttons("uklr")
        )
      )
    )
  })
  observeEvent(input$submit_trans,{
    output$tbl <- DT::renderDT(
      server = FALSE,
      DT::datatable(
        tbl_trans_srv(),
        rownames = FALSE,
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          searching = FALSE,
          # autoWidth = TRUE,
          paging = TRUE,
          lengthChange = FALSE,
          pageLength = 20,
          # scrollX = T,
          buttons = specify_buttons("uklr")
        )
      )
    )
  })



}
