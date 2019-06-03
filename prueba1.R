require("rgdal")
require("maptools")
require("ggplot2")
require("plyr")

# read temperature data
setwd("/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/")
temp.data        <- readOGR(dsn=".", layer="escuelas_df")
temp.data$CODINE <- str_pad(temp.data$CODINE, width = 5, side = 'left', pad = '0')

# read municipality polygons
setwd("/Users/emiranda/Downloads/GEO_Ecologia/practica_R_escuelas/")
esp     <- readOGR(dsn=".", layer="red_df")
muni    <- subset(esp, esp$class_id == "101" | esp$class_id == "102" | esp$class_id == "103")
# fortify and merge: muni.df is used in ggplot
muni@data$id <- rownames(muni@data)
muni.df <- fortify(muni)
muni.df <- join(muni.df, muni@data, by="id")
muni.df <- merge(muni.df, temp.data, by.x="CODIGOINE", by.y="CODINE", all.x=T, a..ly=F)
# create the map layers
ggp <- ggplot(data=muni.df, aes(x=long, y=lat, group=group)) 
ggp <- ggp + geom_polygon(aes(fill=LEVEL))         # draw polygons
ggp <- ggp + geom_path(color="grey", linestyle=2)  # draw boundaries
ggp <- ggp + coord_equal() 
ggp <- ggp + scale_fill_gradient(low = "#ffffcc", high = "#ff4444", 
                                 space = "Lab", na.value = "grey50",
                                 guide = "colourbar")
ggp <- ggp + labs(title="Temperature Levels: Comunitat Valenciana")
# render the map
print(ggp)
