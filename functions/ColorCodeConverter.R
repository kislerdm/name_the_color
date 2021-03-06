#### Name the Color App
## author: D.Kisler <admin@dkisler.de>
## function to convert hex to rgb
hex2rgb <- function(hex) {
  if(!grepl('^#', hex))
    hex <- paste0('#', gsub('#', '', hex))
  rgb <- tryCatch(grDevices::col2rgb(hex), error = function(c) return(NULL))
  if (is.null(rgb))
    return(rgb)
  return( rgb %>% as.list() %>% `names<-`(c('r', 'g', 'b')) ) 
}

## function to convert rgb to hex
rgb2hex <- function(r = NULL, g = NULL, b = NULL) {
  if (is.null(r) | is.null(g) | is.null(b))
    return(NULL)
  #normalize the color code
  rgbNorm <- function(col) ifelse(col >= 1, col/255, col)
  grDevices::rgb(rgbNorm(r), rgbNorm(g), rgbNorm(b))
}

## find the nearest color
findNearestColor <- function(in_r, in_g, in_b, df_ref, top = 1) {
  if (is.null(in_r) | is.null(in_g) | is.null(in_b))
    return(NULL)
  df_ref %>% 
    mutate(dist = sqrt((in_r - r)^2 + (in_g - g)^2 + (in_b - b)^2)) %>% 
    arrange(dist) %>%
    filter(row_number() <= top) %>% 
    data.frame()
}
