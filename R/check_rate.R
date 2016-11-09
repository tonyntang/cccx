#' Check Credit Card Currency Exchange Rate
#' @name check
#' @import rvest lubridate stringr xml2
NULL

#' @export
#' @rdname check
check_visa <- function(home_cur = "USD", foriegn_cur = "CAD", fee = 0, date = today())
{
  date <- as_date(date)

  visa_page <- "https://usa.visa.com/support/consumer/travel-support/exchange-rate-calculator.html"

  x <- read_html(visa_page)

  cur_code <- x %>%
    html_nodes("#fromCurr option") %>%
    html_attr(name = "value") %>% `[`(-1)

  cur_desc <- x %>%
    html_nodes("#fromCurr option") %>%
    html_text(trim = TRUE) %>% `[`(-1) %>%
    str_replace_all("(\\s)+" , " ")

  stopifnot(home_cur %in% cur_code & foriegn_cur %in% cur_code)

  url <- str_c(visa_page,
               "?fromCurr=", home_cur,
               "&toCurr=", foriegn_cur,
               "&fee=", fee,
               "&exchangedate=", format(today(), "%m/%d/%Y"))

  x <- read_html(url)
  r <- x %>%
    html_nodes(".results strong") %>%
    html_text() %>%
    as.numeric()

  r <- rbind(r, r * (1 / r[2]))

  r <- cbind(r, fee)


 colnames(r) <- c( paste0("Foriegn = ", foriegn_cur),
                   paste0("Home = ", home_cur),
                   "FX Fee")
  r
}
