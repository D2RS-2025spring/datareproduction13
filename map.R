library(maps)
library(ggplot2)
library(dplyr)
setwd("C:/Users/17459/Documents")
data <- read.delim("map-full.txt",header = T)
data$habitat <- factor(data$habitat,levels = c(
  'Animal husbandry',
  'Food',
  'Human',
  'Soil',
  'Surface water',
  'Aquatic organism',
  'Sediment',
  'Wild animal',
  'Plant',
  'Insect',
  'Seawater'
))
world<-map_data("world")
p <- ggplot() +
  geom_polygon(data=world,aes(x=long,y=lat,group=group),
               fill="#dedede")+
  geom_point(data=data,aes(x=longitude,y=latitude,fill=habitat,size=number),shape=21,alpha=0.6)+
  scale_fill_manual(values = c('#BDB9DA',"#80B0D2",'#8DD2C6','#FA8071',"#B3DE69",
                               "#D9D9D9","#CCEBC5","#FBCDE4","#FCB461","#BB80BC","#FFEC6D"))+
  scale_y_continuous(expand = expansion(mult=c(0,0)))+
  scale_x_continuous(expand = expansion(add=c(0,0)))+
  theme_void()

p

ggsave('map-full.pdf',p,width = 11,height = 5)
ggsave("C:/Users/17459/Desktop/test.png", plot = p)  

map_plot <- ggplot() +
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90, 
           fill = "#cceeff", color = NA) +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#dedede", color = "gray60", size = 0.2) +
  geom_point(data = data, aes(x = longitude, y = latitude, fill = habitat, size = number),
             shape = 21, alpha = 0.7, stroke = 0.5, color = "white") +
  scale_fill_manual(values = habitat_colors, name = "生境类型") +
  scale_size_continuous(range = c(2, 8), name = "数量") +
  scale_y_continuous(
    limits = c(-90, 90), 
    expand = expansion(mult = c(0, 0)),
    name = "纬度"
  ) +
  scale_x_continuous(
    limits = c(-180, 180), 
    expand = expansion(mult = c(0, 0)),
    name = "经度"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_line(color = "gray90", size = 0.2),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10, color = "gray30"),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 9),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.key.size = unit(0.8, "lines"),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray40"),
    plot.margin = margin(10, 10, 10, 10)
  ) +
  labs(
    title = "全球生境分布与数量可视化",
    subtitle = "数据来源: map-full.txt"
  )

print(map_plot)
save_path <- "C:/Users/17459/Desktop/"  

ggsave(paste0(save_path, "map_improved.pdf"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(paste0(save_path, "map_improved.png"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(paste0(save_path, "map_improved.tif"), map_plot, width = 11, height = 5, dpi = 300)

