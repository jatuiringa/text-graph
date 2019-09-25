# Debemos activar el paquete TM e igraph
library(tm)
require(igraph)
setwd("C:/Users/asalazar/Dropbox/GF")
#este codigo nos permite leer la carpeta, usar el simbolo "/" no "\"
c1998 <- Corpus(DirSource("C:/Users/asalazar/Dropbox/GF/Guarico/acc"))

paraiso <- read_delim("C:/Users/asalazar/Dropbox/GF/Guarico Alcaravan GF 2.csv",";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),    trim_ws = TRUE)
cols(
  Persona = col_character(),
  texto = col_character(),
  sexo = col_character(),
  CC = col_character()
)
#limpieza del corpus
c1998 <- tm_map(c1998, content_transformer(tolower))
c1998 <- tm_map(c1998, removePunctuation)
c1998 <- tm_map(c1998, stripWhitespace)
c1998 <- tm_map(c1998, removeNumbers)
c1998 <- tm_map(c1998, removeWords, c("que", "mis", "los", "las", "con", "sino",
                                      "ahí", "ante","así", "del", "aquí", "eso", "esa",
                                      "esa", "dos", "este","esta", "está", "muy", "han",
                                      "ese", "sea", "esas", "aprendieron","ataque", "abajo",
                                      "porque", "para", "pero", "por", "via", "abandonada", "abarca",
                                      "abre", "abril", "abro", "abrí", "absorvido", "acabé", "acabo",
                                      "administrativa", "afluencia", "alboroto", "amora","abra", "abajo",
                                      "abría", "acaban", "acabó", 
                                      "abre", "abril", "abro", "abrí", "abrir", "acaso", "acepté",
                                      "acabar", "alo", "altura", "andar", "aparte", "asa", "baja",
                                      "aca", "abstiene", "abuela"))
#Creamos la matriz doble
c1998 <- TermDocumentMatrix(c1998)
c1998<-removeSparseTerms(c1998, 0.9)
dc1998 <- removeSparseTerms(c1998, sparse = 0.975)
c1998 <- as.matrix(c1998)
c1998 <- c1998 %*% t(c1998)
diag(c1998)<-0
c1998[1:9, 1:5]
grafoc1998 <- graph.adjacency (c1998, weighted = TRUE, mode= 'directed')
write.graph (grafoc1998, file = 'Paraiso.graphml', format = 'graphml')