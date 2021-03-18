library(httr)
library(jsonlite)




urlBase = 'https://api.invertironline.com'
url=paste('https://api.invertironline.com/token')#, '?username=jmtruffa@gmail.com&password=Nibj$UsBC@9^5Q&grant_type=password', sep = '')
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

