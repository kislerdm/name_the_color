#### Name the Color App
## author: D.Kisler <admin@dkisler.de>
## inspired by http://chir.ag/projects/name-that-color
#selectors updater function
#
update_rgb_slider <- function(session, rgb) {
  for (iCol in c('r', 'g', 'b') )
    updateSliderInput(session, inputId = paste0(iCol, '_in'), value = rgb[[iCol]])
}
#
update_col_name <- function(session, hex, ref) {
  name <- ref$color_name[ref$hex == toupper(hex)]
  if(length(name) == 0) name <- "Unknown"
  updateTextInput(session, inputId = 'col_name', value = name[1])
}
#
updater <- function(session, input, ref, selector = 'palette') {
  if (selector == 'palette' | selector == 'hex') {
    hex <- input$col_palette
    if(selector == 'hex')
      hex <- input$hex_in
    update_rgb_slider(session, hex2rgb(hex))
    #update_col_name(session, hex, ref)
    updateTextInput(session, inputId = 'hex_in', value = hex)
    updateColourInput(session, inputId = 'col_palette', value = hex)
  } else if (selector == 'rgb') {
    hex <- rgb2hex(input$r_in, input$g_in, input$b_in)
    # update_col_name(session, hex, ref)
    updateTextInput(session, inputId = 'hex_in', value = hex)
    updateColourInput(session, inputId = 'col_palette', value = hex)
  } else if (selector == 'name_known') {
    # color_found <- getColorbyName(input$col_name_known, ref)
    color_found <- ref[ref$color_name == input$col_name_known]
    if (!is.null(color_found)) {
      updateTextInput(session, inputId = 'hex_in', value = color_found$hex)
      updateColourInput(session, inputId = 'col_palette', value = color_found$hex)
      update_rgb_slider(session, color_found)
      updateTextInput(session, inputId = 'col_name', value = input$col_name_known)
    }
  }
}
