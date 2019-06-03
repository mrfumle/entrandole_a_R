require(rgdal)
require(sf)
library(dismo)
library(ggplot2)

############################################
#
# Identificar las escuelas cercanas a calles con volumen 
# potencialmente alto de tráfico vehicular: Las calles con alto volumen  
# están etiquetadas en class_id:101,102,103,106,107,108.
#
# Seleccionar de la tabla de todas las calles las identificadas con mucho tráfico, 
# después hacer un buffer sobre la selección y luego la intersección con las escuelas.
############################################

# Metemos los shapes en unas variables
cdmx <- read_sf('/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/red_df.shp')
escuelas_df <- read_sf('/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/escuelas_df.shp')

# Dibujamos los datos
plot(st_geometry(cdmx))
plot(st_geometry(escuelas_df))

cdmx$class_id
cdmx$class_id %in% c("101", "102",  
                     "103", "106", "107", "108")

cdmx_filtered <- filter(cdmx, cdmx$class_id %in% c("101", "102",  
                                                   "103", "106", "107", "108"))
escuelas_sub<-escuelas_df %>% 
  top_n(20)

aa <- st_distance(escuelas_sub, cdmx_filtered)
plot(cdmx, max.plot = 1)

plot(st_boundary(cdmx["class_id"]))
plot(st_intersection(st_union(cdmx),st_union(y)), add = TRUE, col = 'red')
