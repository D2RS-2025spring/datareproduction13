# 加载必要的包
library(maps)
library(ggplot2)
library(dplyr)
library(here)

# 构建相对路径
data_path <- here("data", "map-full.txt")

# 检查文件是否存在
if (!file.exists(data_path)) {
  stop(paste("错误：文件不存在 -", data_path))
}

# 读取数据
data <- read.delim(data_path, header = TRUE)

# 设置因子水平
data$habitat <- factor(data$habitat, levels = c(
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

print(final_map)

# 保存地图
ggsave(here("figures", "lab_sample_map.png"), 
       plot = final_map, 
       width = 10, height = 8, dpi = 300)

# 输出摘要统计
habitat_counts <- table(data$habitat)
print("栖息地样本数量分布:")
print(habitat_counts)

# 输出统计结果到文件
sink(here("output", "habitat_summary.txt"))
cat("实验室样本统计摘要\n====================\n\n")
cat("总样本数:", nrow(data), "\n\n")
cat("栖息地分布:\n")
print(habitat_counts)
cat("\n经纬度范围:\n")
print(summary(data[, c("longitude", "latitude")]))
sink()

# 加载必要的包
library(maps)
library(ggplot2)
library(dplyr)
library(here)

# 构建相对路径
data_path <- here("data", "map-full.txt")

# 检查文件是否存在
if (!file.exists(data_path)) {
  stop(paste("错误：文件不存在 -", data_path))
}

# 读取数据
data <- read.delim(data_path, header = TRUE)

# 设置因子水平
data$habitat <- factor(data$habitat, levels = c(
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

# 定义生境颜色
habitat_colors <- c(
  'Animal husbandry' = '#E41A1C',
  'Food' = '#377EB8',
  'Human' = '#4DAF4A',
  'Soil' = '#984EA3',
  'Surface water' = '#FF7F00',
  'Aquatic organism' = '#FFFF33',
  'Sediment' = '#A65628',
  'Wild animal' = '#F781BF',
  'Plant' = '#999999',
  'Insect' = '#E6AB02',
  'Seawater' = '#66C2A5'
)

# 获取世界地图数据
world <- map_data("world")

# 数据探索与验证
head(data)
summary(data)
str(data)

# 创建改进的地图
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

# 使用here包统一保存路径到项目的figures目录
save_path <- here("figures")

# 确保保存目录存在
if (!dir.exists(save_path)) {
  dir.create(save_path, recursive = TRUE)
}

# 保存不同格式的地图
ggsave(here(save_path, "map_improved.pdf"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(here(save_path, "map_improved.png"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(here(save_path, "map_improved.tif"), map_plot, width = 11, height = 5, dpi = 300)

# 输出摘要统计
habitat_counts <- table(data$habitat)
print("栖息地样本数量分布:")
print(habitat_counts)

# 输出统计结果到文件
sink(here("output", "habitat_summary.txt"))
cat("实验室样本统计摘要\n====================\n\n")
cat("总样本数:", nrow(data), "\n\n")
cat("栖息地分布:\n")
print(habitat_counts)
cat("\n经纬度范围:\n")
print(summary(data[, c("longitude", "latitude")]))
sink()    

