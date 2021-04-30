error.mail <- FALSE
if(Sys.getenv("ERROR_MAIL") == "yes")
    error.mail <- TRUE
Sys.sleep(30)
try({base::hopkins$removelock()})
if(length(list.files(.Library.site, pattern = "00LOCK")) > 0) {
    Rver <- paste("R-", R.version$major, ".", R.version$minor, sep = "")
    msg <- paste("Unremovable 00LOCK in", .Library.site, "R version", Rver)
    if(error.mail) 
        system(sprintf("echo '%s' | /bin/mail -s '%s' %s",
                       paste("00LOCK in", Rver), msg,
                       "kasperdanielhansen@gmail.com"))
    else
        cat(msg, "\n")
}
rm(list = ls())
