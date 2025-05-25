library(ggradar)
library(ggplot2)
library(gridExtra)
setwd("D:/thisthis/2024-2025-2/exam/data/detection frequency")
data.Aquatic.organism <- read.delim('Aquatic organism pARG detection frequency.txt',header = T)
data.food <- read.delim('food pARG detection frequency.txt',header = T)
data.huamn <-read.delim('human pARG detection frequency.txt',header = T)
data.Insects <- read.delim('insects pARG detection frequency.txt',header = T)
data.animal.husbandry <- read.delim('livetock pARG detection frequency.txt',header = T)
data.Plant <- read.delim('plant pARG detection frequency.txt',header = T)
data.Seawater <- read.delim('seawater pARG detection frequency.txt',header = T)
data.Sediment <- read.delim('sediments pARG detection frequency.txt',header = T)
data.soil <- read.delim('Soil pARG detection frequency.txt',header = T)
data.Wild.animal <- read.delim('wildlife pARG detection frequency.txt',header = T)
data.Surface.water <- read.delim('Fresh water pARG detection frequency.txt',header = T)

#"#C57962","#4B9347","#D37A0F"

range(data.food[,2:12])
p1 <- ggradar( plot.data =data.food,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#78A8C6")
)
p1

ggsave("food prophageARGs检出率.pdf",p1,width = 12,height =8)



range(data.animal.husbandry[,2:12])
p2 <- ggradar( plot.data =data.animal.husbandry,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#BEBADA")
)
p2

ggsave("animal.husbandry prophageARGs检出率.pdf",p2,width = 12,height =8)



range(data.huamn[,2:12])
p3 <- ggradar(plot.data =data.huamn,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#8DD3C7")
)
p3

ggsave("human prophageARGs检出率.pdf",p3,width = 12,height =8)



range(data.soil[,2:12])
p4 <- ggradar(plot.data =data.soil,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#F37D74")
)
p4

ggsave("soil prophageARGs检出率.pdf",p4,width = 12,height =8)



range(data.Sediment[,2:12])
p5 <- ggradar(plot.data =data.Sediment,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#BEE0BE")
)
p5

ggsave("Sediment prophageARGs检出率.pdf",p5,width = 12,height =8)




range(data.Wild.animal[,2:12])
p6 <- ggradar(plot.data =data.Wild.animal,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#F5C2D9")
)
p6

ggsave("Wild.animal prophageARGs检出率.pdf",p6,width = 12,height =8)




range(data.Surface.water[,2:12])
p7 <- ggradar(plot.data =data.Surface.water,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#A0CE3A")
)
p7

ggsave("Surface.water prophageARGs检出率.pdf",p7,width = 12,height =8)




range(data.Aquatic.organism[,2:12])
p8 <- ggradar(plot.data =data.Aquatic.organism,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#9D9E98")
)
p8

ggsave("Aquatic.organism prophageARGs检出率.pdf",p8,width = 12,height =8)




range(data.Insects[,2:12])
p9 <- ggradar(plot.data =data.Insects,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0","50%","100%"),
               background.circle.colour="#C7E6F0",
               fill=T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#AA7CB6")
)
p9

ggsave("Insects prophageARGs检出率.pdf",p9,width = 12,height =8)




range(data.Seawater[,2:12])
p10 <- ggradar(plot.data =data.Seawater,
                grid.min = 0, 
                grid.mid = 0.5, 
                grid.max = 1,
                grid.label.size = 10,
                values.radar = c("0","50%","100%"),
                background.circle.colour="#C7E6F0",
                fill=T,
                fill.alpha = 0.2,  
                group.line.width = 1, 
                group.point.size = 3,
                group.colours = c("#F2E27B")
)
p10

ggsave("Seawater prophageARGs检出率.pdf",p10,width = 12,height =8)

range(data.Plant[,2:12])
p11 <- ggradar(plot.data =data.Plant,
                grid.min = 0, 
                grid.mid = 0.5, 
                grid.max = 1,
                grid.label.size = 10,
                values.radar = c("0","50%","100%"),
                background.circle.colour="#C7E6F0",
                fill=T,
                fill.alpha = 0.2,  
                group.line.width = 1, 
                group.point.size = 3,
                group.colours = c("#D37A0F")
)
p11

ggsave("Plant prophageARGs检出率.pdf",p11,width = 12,height =8)


p <- grid.arrange(p3, p2, p1, p6, p7, p4, p8, p5, p11, p9, p10 ,ncol = 3, nrow =4)
p
ggsave("检出率组合.pdf",p,width =24,height =18)
p2
p3
p6
p1
p7
p4
p8
p5
p11
p9
p10
