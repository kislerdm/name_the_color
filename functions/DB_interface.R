## Name the Color App
## author: D.Kisler <admin@dkisler.de>
# SQL statemets executor

getDBConnection <- function(user, pass, 
                            dbname = 'postgres', host = 'localhost', port = 5432) {
  tryCatch(dbConnect(dbDriver('PostgreSQL'), user = user, pass = pass, dbname = dbname, host = host, port = port),
           error = function(c) return(NULL))
}
#
getDBQuery <- function(con, query, close_con = T) {
  d <- tryCatch(dbGetQuery(con, query), error = function(c) return(NULL))
  if (close_con) invisible(dbDisconnect(con))
  return(d)
}
#
postDBQuery <- function(con, query, close_con = T) {
  d <- tryCatch(dbSendQuery(con, query), error = function(c) return(NULL))
  if (close_con) invisible(dbDisconnect(con))
  return(d)
}
