## Name the Color App
## author: D.Kisler <admin@dkisler.de>
# functions to add new color
ColorAddVerificator <- function(input) {
  # check the color name and code fiels
  if ((nchar(input$add_color_name, type = 'byte') == 0) | 
      ((nchar(input$add_color_hex, type = 'byte') == 0) & (nchar(input$add_color_rgb, type = 'byte') == 0)) ) return(NULL)
  # verify the color code 
  # HEX
  if (nchar(input$add_color_hex, type = 'byte') > 0) {
    rgb <- hex2rgb(input$add_color_hex)
    if (is.null(rgb)) return(NULL)
    return(list(color_name = input$add_color_name, 
                hex = input$add_color_hex,
                r = rgb$r, g = rgb$g, b = rgb$b))
  }
  # RGB
  if ( (nchar(input$add_color_hex, type = 'byte') == 0) &
       (nchar(input$add_color_rgb, type = 'byte') > 0) ) {
    rgb <- input$add_color_rgb %>% strsplit(., ',') %>% unlist() %>% as.integer() %>% .[!is.na(.)]
    if (length(rgb) < 3) return(NULL)
    return(list(color_name = input$add_color_name, 
                hex = rgb2hex(rgb[1], rgb[2], rgb[3]),
                r = rgb[1], g = rgb[2], b = rgb[3]))
  }
}
# insert new color into DB
ColorAdddDB <- function(credentials, query, color_info) {
  con <- getDBConnection(user = credentials$user, pass = credentials$pass)
  if (is.null(con)) return(F)
  test <- tryCatch({ 
    query %>% 
      gsub('\\@color_name\\@', color_info$color_name, .) %>% 
      gsub('\\@hex\\@', color_info$hex, .) %>% 
      gsub('\\@r\\@', color_info$r, .) %>%  gsub('\\@g\\@', color_info$g, .) %>%  gsub('\\@b\\@', color_info$b, .) %>% 
      postDBQuery(con, query = .)
  }, 
  error = function(c) return(F))
  if (is.null(test)) return(F)
  return(T)
}
