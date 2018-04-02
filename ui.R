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
                       column(9,
                              tags$div(id = 'palette_hex', uiOutput('col_palette_sel'), align = 'left'),
                              colourInput("col_palette", NULL, showColour = "background")
                       ),
                       column(3, 
                              selectInput('col_name', label = 'Display Color by Name', choices = 'White', multiple = F),
                              bsButton('add_color', label = 'Add Color', icon = icon(name = 'plus', lib = 'font-awesome'), style = 'success'),
                              bsPopover('add_color', title = NULL, content = 'Cannot find your color? Please add it!',  
                                        placement = "bottom", trigger = "hover", options = NULL),
                              # add new color popup
                              bsModal('add_color_popup', trigger = 'add_color', title = 'Add New Color', size = 'small',
                                      tags$h5('Enter the Color Name*'),
                                      textInput(inputId = 'add_color_name', label = NULL, width = '100%', value = NULL, placeholder = 'Please enter the color name'),
                                      tags$h5('Enter the Color Code*'),
                                      tabsetPanel(id = 'add_color_code', selected = 'hex', type = 'pills',
                                                  tabPanel(title = 'By HEX', value = 'hex', textInput('add_color_hex', NULL, value = NULL, placeholder = 'Enter HEX color code, e.g. #FFFFFF') ),
                                                  tabPanel(title = 'By RGB', value = 'rgb', textInput('add_color_rgb', NULL, value = NULL, placeholder = 'Enter RGB color code, e.g. 255,255,255') )
                                      ),
                                      footer = tagList(
                                        bsButton("add_apply", label = "Apply", style = 'warning', disabled = T),
                                        tags$div(HTML("<em><strong>*</strong> required fields</em>"), align = 'left')
                                      )
                              )
                       )
                   ),
                   box(background = NULL, solidHeader = F, title = 'Color Settings', collapsible = T, width = 12, align = "center",
                       column(4, 
                              tags$div(id = 'hex_in', HTML('<h4>HEX Code</h4>'), textInput('hex_in', NULL, value = "#FFFFFF"))),
                       column(8, 
                              tags$div(id = 'rgb_in', 
                                       HTML('<h4>RGB Code</h4>'),
                                       sliderInput('r_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'R = ', animate = T),
                                       sliderInput('g_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'G = ', animate = T),
                                       sliderInput('b_in', label = NULL, min = 0, max = 255, step = 1, ticks = F, value = 255, pre = 'B = ', animate = T))
                       )
                   ),
                   box(background = NULL, solidHeader = F, title = 'About', collapsible = T, collapsed = T, width = 12, align = "center",
                       tags$div(id = 'about', includeMarkdown('README.md'), align = 'left')
                       )
               )
             ),
             column(width = 12, tags$div(HTML(paste0(format(Sys.Date(), '%Y'), " © <a href='https://www.dkisler.de' target='blank_'>Dmitry Kisler</a>",
                                                     "<br>See the code on <a href='https://github.com/kislerdm/name_the_color' target='blank_'>",
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