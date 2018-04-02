## Name the Color App
## author: D.Kisler <admin@dkisler.de>
# UI code
body <- dashboardBody(
  includeCSS('www/styles.css'),
  tags$div(id = 'body',  
           fluidPage(
             fluidRow(
               useShinyjs(),
               column(2),
               box(background = NULL, solidHeader = T, title = NULL, collapsible = F, width = 8, align = "center",
                   box(background = NULL, solidHeader = F, title = 'Palette', collapsible = F, width = 12, align = "center",
                       tags$div(id = 'palette_hex', uiOutput('col_palette_sel'), align = 'left'),
                       colourInput("col_palette", NULL, showColour = "background")
                   ),
                   box(background = NULL, solidHeader = F, title = 'Color Settings', collapsible = T, width = 12, align = "center",
                       column(4, 
                              tags$div(id = 'hex_in', HTML('<h4>HEX Code</h4>'), textInput('hex_in', NULL, value = "#FFFFFF"))),
                       column(8, 
                              tags$div(id = 'rgb_in', 
                                       HTML('<h4>RGB Code</h4>'),
                                       sliderInput('r_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'R = '),
                                       sliderInput('g_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'G = '),
                                       sliderInput('b_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'B = '))
                       )
                   ), 
                   box(background = NULL, solidHeader = F, title = 'Color Name', collapsible = T, width = 12, align = "center",
                       column(6, textInput('col_name', 'Guess Color by Name', value = "White")),
                       column(6, tags$div(selectInput('col_name_known', 'Display Color by Name', choices = 'White', multiple = F)))
                   )
               )
             ),
             column(width = 12, tags$div(HTML(paste0(format(Sys.Date(), '%Y'), " © <a href='https://www.dkisler.de' target='blank_'>Dmitry Kisler</a>",
                                                     "<br>See the code on <a href='https://github.com/kislerdm' target='blank_'>",
                                                     '<img title="GitHub" src="https://image.flaticon.com/icons/svg/24/24233.svg" width="20" height="20"/></a>')), align = "center"))
           )
  )
)
#
ui <- dashboardPage(
  title = "Name this Color",
  header = dashboardHeader(title = "Name this Color", titleWidth = "100%"),
  body = body,
  sidebar = dashboardSidebar(disable = T) 
)