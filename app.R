## Name the Color App
## author: D.Kisler <admin@dkisler.de>
## inspired by http://chir.ag/projects/name-that-color
#app logic
source('app_settings.R', verbose = F, echo = F)
# the app's 'backend'
server <- function(input, output, session) {
  source('app_settings_reactive.R')
  #read the colors data
  dat <<- getDBConnection(user = credentials$user, pass = credentials$pass) %>% getDBQuery(., q_fetch_all_colors)
  #update known colors dropdown menue
  updateSelectInput(session, 'col_name', choices = dat$color_name, selected = sample(dat$color_name, 1))
  #update selectors on the color name input
  observeEvent(input$col_name, updater(session, input, ref = dat, selector = 'color_name'))
  #output selected palette color
  output$col_palette_sel <- renderUI({
    color_name_guess <- findNearestColor(input$r_in, input$g_in, input$b_in, dat, 1)
    return( HTML(paste0("<strong>Guess color name</strong>: ", color_name_guess$color_name)) )
  })
  #show the tot numb of colors in DB
  output$n_cols <- renderUI( HTML(paste0("<strong>Numb. of colors in DB</strong>: ", nrow(dat))) ) 
  #update selectors on color palette input
  observeEvent(input$col_palette, updater(session, input, ref = dat, selector = 'palette'), autoDestroy = T)
  #update selectors on hex code input
  observeEvent(input$hex_in, updater(session, input, ref = dat, selector = 'hex'), autoDestroy = T)
  #update selectors on rgb slider input
  observeEvent(input$r_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
  observeEvent(input$g_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
  observeEvent(input$b_in, updater(session, input, ref = dat, selector = 'rgb'), autoDestroy = T)
  
  ## logic to add new color
  # verify the color data input
  observe({
    input_check <- ColorAddVerificator(input)
    if (!is.null(input_check)) {
      updateButton(session, 'add_apply', label = "  Apply", icon = icon(name = "ok-sign", lib = 'glyphicon'), style = 'success', disabled = F)
      observeEvent(input$add_apply, {
        updateButton(session, 'add_apply', label = 'Writing to DB...', icon = icon(name = 'spinner', class = 'fa-pulse fa-fw', lib = 'font-awesome'), disabled = T)
        db_write_ok <- ColorAdddDB(credentials, query = q_add_color, color_info = input_check)
        if (!db_write_ok) {
          updateButton(session, 'add_apply', label = 'Error...', icon = icon(name = NULL), style = 'danger', disabled = T)
        } else {
          dat <<- getDBConnection(user = credentials$user, pass = credentials$pass) %>% getDBQuery(., q_fetch_all_colors)
          updater(session, input, ref = dat, selector = 'add_color')
        }
      }, autoDestroy = T)
    } else {
      updateButton(session, 'add_apply', icon = icon(name = NULL), style = 'warning', disabled = T)
    }
  })
}

shinyApp(ui, server, enableBookmarking = 'url')