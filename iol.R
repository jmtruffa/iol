library(httr)
library(jsonlite)




urlBase = 'https://api.invertironline.com'
URL_ACCOUNT_STATE = "/api/v2/estadocuenta"
URL_MARKET_RATES = "/api/v2/Cotizaciones/{instrument}/{panel}/{country}"
URL_MUTUAL_FUND = "/api/v2/Titulos/FCI/{symbol}"
URL_MUTUAL_FUND_IN_MARKET = "/api/v2/{market}/Titulos/{symbol}"
URL_MUTUAL_FUND_OPTIONS = "/api/v2/{market}/Titulos/{symbol}/Opciones"
URL_MUTUAL_FUNDS = "/api/v2/Titulos/FCI"
URL_MUTUAL_FUNDS_ADMINS = "/api/v2/Titulos/FCI/Administradoras"
URL_MUTUAL_FUNDS_BY_ADMIN_AND_TYPE = "/api/v2/Titulos/FCI/Administradoras/{admin}/TipoFondos/{fcitype}"
URL_MUTUAL_FUNDS_TYPES = "/api/v2/Titulos/FCI/TipoFondos"
URL_MUTUAL_FUNDS_TYPES_BY_ADMIN = "/api/v2/Titulos/FCI/Administradoras/{admin}/TipoFondos"
URL_INSTRUMENT = "/api/v2/{country}/Titulos/Cotizacion/Paneles/{instrument}"
URL_INSTRUMENTS = "/api/v2/{country}/Titulos/Cotizacion/Instrumentos"
URL_OPERATE_BUY = "/api/v2/operar/Comprar"
URL_OPERATE_SELL = "/api/v2/operar/Vender"
URL_OPERATE_SUBSCRIBE = "/api/v2/operar/suscripcion/fci"
URL_OPERATE_RESCUE = "/api/v2/operar/rescate/fci"
URL_OPERATION = "/api/v2/operaciones/{number}"
URL_OPERATIONS = "/api/v2/operaciones/"
URL_OPERATIONS_DELETE = "/api/v2/operaciones/{number}"
URL_PORTFOLIO = "/api/v2/portafolio/{country}"
URL_STOCK = "/api/v2/{market}/Titulos/{symbol}/Cotizacion"
URL_STOCK_HISTORY = "/api/v2/{market}/Titulos/{symbol}/Cotizacion/seriehistorica/{date_from}/{date_to}/{fit}"
URL_TOKEN = "/token"

getToken = function(refreshToken = NULL, grantType = 'password') {
  if (gran_type == 'password') {
    body2 = list(username = Sys.getenv("userid.iol"),
                password = Sys.getenv("pwd.iol"),
                grant_type = 'password')
  } else {
      body = list(refresh_token = refreshToken, grant_type = grantType)
  }
  response = POST(paste0(urlBase, URL_TOKEN),
                         body2,
                         encode = 'form', verbose())
  response
}


url=paste('https://api.invertironline.com/token')
urlGetPrices = 'https://api.invertironline.com/api/v2/{Mercado}/Titulos/{Simbolo}/Cotizacion'
urlSerieHistorica = '/api/v2/{mercado}/Titulos/{simbolo}/Cotizacion/seriehistorica/{fechaDesde}/{fechaHasta}/{ajustada}'
res = POST(url,
           body=list(username=Sys.getenv("userid.iol"),
                     password=Sys.getenv("pwd.iol"),
                     grant_type='password'), encode = 'form', verbose())
data = fromJSON(rawToChar(res$content))

token = paste('Bearer', data[["access_token"]])



price = GET(urlGetPrices,
            add_headers("Authorization" = token),
            query = list(mercado = "argentina",
                         simbolo = "AL30D",
                         model.simbolo = "AL30D",
                         model.mercado= "bCBA",
                         model.plazo= "t2"),
            encode = 'json', verbose())
dataPrice = fromJSON(rawToChar(price$content))
dataPrice$ultimoPrecio


histPrice = GET(paste(urlBase, urlSerieHistorica, sep =''),
                add_headers("Authorization" = token),
                query = list(mercado = "bCBA",
                             simbolo = "AL30D",
                             fechaDesde = '03/01/2021',
                             fechaHasta = '05/03/2021',
                             ajustada = 'ajustada'),
                encode = 'json', verbose())
datahistPrice = fromJSON(rawToChar(histPrice$content))
datahistPrice

