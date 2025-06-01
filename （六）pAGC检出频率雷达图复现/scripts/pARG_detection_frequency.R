# 加载必要的包
if (!requireNamespace("here", quietly = TRUE)) install.packages("here")
if (!requireNamespace("ggradar", quietly = TRUE)) install.packages("ggradar")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("gridExtra", quietly = TRUE)) install.packages("gridExtra")
if (!requireNamespace("grid", quietly = TRUE)) install.packages("grid")
library(here)
library(ggplot2)
library(ggradar)
library(gridExtra)
library(grid)

# 定义文件夹路径，使用 here 包构建相对路径
folder_path <- here("detection frequency")

# 为每个环境样本类型的数据文件构建完整的文件路径
aquatic_file <- file.path(folder_path, "Aquatic organism pARG detection frequency.txt")
food_file <- file.path(folder_path, "food pARG detection frequency.txt")
human_file <- file.path(folder_path, "human pARG detection frequency.txt")
insects_file <- file.path(folder_path, "insects pARG detection frequency.txt")
livestock_file <- file.path(folder_path, "livetock pARG detection frequency.txt")
plant_file <- file.path(folder_path, "plant pARG detection frequency.txt")
seawater_file <- file.path(folder_path, "seawater pARG detection frequency.txt")
freshwater_file <- file.path(folder_path, "Fresh water pARG detection frequency.txt")
sediments_file <- file.path(folder_path, "sediments pARG detection frequency.txt")
soil_file <- file.path(folder_path, "soil pARG detection frequency.txt")
wildlife_file <- file.path(folder_path, "wildlife pARG detection frequency.txt")

# 读取不同环境样本类型的数据文件
data.Aquatic.organism <- read.delim(aquatic_file, header = T)
data.food <- read.delim(food_file, header = T)
data.human <-read.delim(human_file, header = T)
data.insects <- read.delim(insects_file, header = T)
data.animal.husbandry <- read.delim(livestock_file, header = T)
data.Plant <- read.delim(plant_file, header = T)
data.Seawater <- read.delim(seawater_file, header = T)
data.Sediment <- read.delim(sediments_file, header = T)
data.soil <- read.delim(soil_file, header = T)
data.Wild.animal <- read.delim(wildlife_file, header = T)
data.Surface.water <- read.delim(freshwater_file, header = T)

# 雷达图绘制
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

range(data.human[,2:12])
p3 <- ggradar(plot.data =data.human,
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

range(data.insects[,2:12])
p9 <- ggradar(plot.data =data.insects,
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

ggsave("insects prophageARGs检出率.pdf",p9,width = 12,height =8)

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


# 创建图例数据
legend_data <- data.frame(
  Environment = c("Human", "Livestock", "Food", "Wildlife", "Fresh water", "Soil",
                  "Aquatic organism", "Sediment", "Plant", "Insects", "Seawater"),
  Color = c("#8DD3C7", "#BEBADA", "#78A8C6", "#F5C2D9", "#A0CE3A", "#F37D74",
            "#9D9E98", "#BEE0BE", "#D37A0F", "#AA7CB6", "#F2E27B")
)

# 创建紧凑的图例
library(grid)
legend_grob <- legendGrob(
  labels = legend_data$Environment,
  pch = 21, 
  gp = gpar(
    fill = legend_data$Color,
    col = "white",
    fontsize = 10,  
    fontface = "bold",
    cex = 3      
  ),
  nrow = 6,       
  ncol = 2,        
  byrow = TRUE,
  hgap = unit(1, "cm"),  # 减小水平间距
  vgap = unit(0.5, "cm")   # 减小垂直间距
)

# 创建3x4布局，将图例放在右下角
final_plot <- grid.arrange(
  p3, p2, p1,
  p6, p7, p4,
  p8, p5, p11,
  p9, p10, legend_grob,
  
  ncol = 3,
  nrow = 4,
  top = textGrob("pARG detection frequency", 
                 gp = gpar(fontsize = 40, fontface = "bold")),
  padding = unit(3, "cm")
)

# 保存带图例的组合图
ggsave("pAGR-detection-frequency.png", final_plot, width = 24, height = 22, dpi = 300, limitsize = FALSE)


