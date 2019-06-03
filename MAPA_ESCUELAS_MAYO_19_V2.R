library(tidyverse)
library(sf)
library(raster)
library(dplyr)
library(spData)

############################################
#
# Identificar en un mapa las escuelas cercanas a calles con volumen 
# potencialmente alto de tráfico vehicular: Las calles con volumen con tráfico 
# están etiquetadas por la class_id:101,102,103,106,107 y 108.
#
# Seleccionar de la tabla de todas las calles las identificadas con mucho tráfico, 
# después hacer un buffer sobre la selección y luego la intersección con las escuelas.
############################################


cdmx_shape <- read_sf('/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/red_df.shp')
schools_cdmx <- read_sf('/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/escuelas_df.shp')

cdmx_shape %>%
  filter(!is.na(class_id)) %>% 
  group_by(class_id) %>%
  summarise() %>%
  ggplot() +
  geom_sf(aes(fill = factor(class_id)))

plot(st_geometry(cdmx_shape))
ls = st_nearest_points(cdmx_shape[1,], cdmx_shape)
plot(ls, col = 'red', add = TRUE)
