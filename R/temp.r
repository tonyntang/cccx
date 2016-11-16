library(httr)

visa_url <- "https://sandbox.api.visa.com/forexrates/v1/foreignexchangerates"

body <- list(destinationCurrencyCode = "840",
             sourceCurrencyCode = "124",
             sourceAmount = "100")

userid <- "0PF4QZ243BZPJB0VX15B21gUaSpnorQFj7bCK3U6VpSgf-Lmc"
passwd <- "T7B5H7u0xhj45n7TNAo9k46idCAHHWI0I25Ws"
key_file <- "C:/Rworks/visa_api/key_13bb75be-ba35-4f3e-ab36-b0f100013938.pem"
cert_file <- "C:/Rworks/visa_api/cert.pem"
cainfo_file <- "C:/Rworks/visa_api/VDPCA-SBX.pem"


x <- POST(visa_url,
          body = body,
          encode = "json",
          authenticate(userid, passwd),
          add_headers("User-Agent" = "Mozilla/5.0"),
          config(sslkey = key_file,
                 sslcert = cert_file),
          verbose())



  x <- GET("https://www.mastercard.us/settlement/currencyrate/settlement-currencies",
           add_headers("User-Agent" = "Mozilla/5.0"))
  x <- content(x)

  currency <- as.data.frame(t(sapply(x$data$currencies, function(x) {c(CODE = x$alphaCd, DESC = trimws(x$currNam))})))


  x <- GET("https://www.mastercard.us/settlement/currencyrate/fxDate=2016-11-14;transCurr=CAD;crdhldBillCurr=USD;bankFee=0;transAmt=1/conversion-rate",
           add_headers("User-Agent" = "Mozilla/5.0"))
