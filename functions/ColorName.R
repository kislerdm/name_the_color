#### Name the Color App
## author: D.Kisler <admin@dkisler.de>
#function to get color by its name
getColorbyName <- function(col_name, ref) {
  #get the color's hex
  col_name <- gsub('-|_|[0-9|[ ]{1,}', '', tolower(col_name))
  #found colors
  cols_found <- ref[tolower(ref$color_name) == col_name, ]
  if(nrow(cols_found) == 0)
    return(NULL)
  return(cols_found[1, ])
}
