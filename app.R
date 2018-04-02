## Name the Color App
## author: D.Kisler <admin@dkisler.de>
## inspired by http://chir.ag/projects/name-that-color
#app logic
source('app_settings.R', verbose = F, echo = F)
# the app's 'backend'
server <- function(input, output, session) {
  source('app_settings_reactive.R')
  #read the colors data
  dat <- fread('colors.csv')
  #update known colors dropdown menue
  updateSelectInput(session, 'col_name_known', choices = dat$color_name[order(dat$color_name)], selected = 'White')
  #update selectors on the color name input
  observeEvent(input$col_name_known, updater(session, input, ref = dat, selector = 'name_known'))
  #output selected palette color
  output$col_palette_sel <- renderUI({
    color_name_guess <- findNearestColor(input$r_in, input$g_in, input$b_in, dat, 1)
    return(
      HTML(paste0("<strong>Guess color name</strong>: ", color_name_guess$color_name))
    )
  })
  #update selectors on color palette input
  observeEvent(input$col_palette, updater(session, input, ref = dat, selector = 'palette'), autoDestroy = T)
  #update selectors on hex code input
  observeEvent(input$hex_in, updater(session, input, ref = dat, selector = 'hex'), autoDestroy = T)
  #update selectors on rgb slider input
  observeEvent(input$r_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
  observeEvent(input$g_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
  observeEvent(input$b_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
}

shinyApp(ui, server, enableBookmarking = 'url')