# （一）全球样本分布地图可视化项目
来源：Liao H, Liu C, Zhou S, et al. Prophage-encoded antibiotic resistance genes are enriched in human-impacted environments. Nature Communications. 2024;15(1):8315. doi:10.1038/s41467-024-52450-y
图4a
## 项目概述
本项目使用R语言创建全球分布图，展示不同栖息地类型（如动物养殖、食物、人类、土壤等）在全球的分布情况，并通过点的大小反映样本数量。

## 环境准备
1. **安装R语言环境**：[下载R](https://cran.r-project.org/)  
2. **安装RStudio**（可选但推荐）：[下载RStudio](https://www.rstudio.com/products/rstudio/download/)  
3. **安装必要的R包**：
   ```r
   install.packages(c("maps", "ggplot2", "dplyr"))
 ## 数据说明
数据文件：map-full.txt
数据格式：制表符分隔的文本文件（TSV），包含以下列：
longitude：经度坐标
latitude：纬度坐标
habitat：栖息地类型（需匹配代码中的 11 个级别）
number：样本数量（用于控制点大小）
## 代码说明
下面是核心代码，主要分为数据处理、地图绘制和结果保存三部分：
### 加载必要的包
library(maps)
library(ggplot2)
library(dplyr)

### 设置工作目录（根据实际情况修改）
setwd("C:/Users/17459/Documents")

### 读取数据
data <- read.delim("map-full.txt", header = T)

### 将habitat列转换为有序因子
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

### 获取世界地图数据
world <- map_data("world")

### 创建地图
p <- ggplot() +
  #### 制世界地图背景
  geom_polygon(data = world, aes(x = long, y = lat, group = group), fill = "#dedede") +
  ####  添加数据点
  geom_point(data = data, aes(x = longitude, y = latitude, fill = habitat, size = number), 
             shape = 21, alpha = 0.6) +
  ####  设置颜色方案
  scale_fill_manual(
    values = c('#BDB9DA', "#80B0D2", '#8DD2C6', '#FA8071', "#B3DE69",
               "#D9D9D9", "#CCEBC5", "#FBCDE4", "#FCB461", "#BB80BC", "#FFEC6D"),
    name = "Habitat Type"
  ) +
  ####  设置点大小范围
  scale_size_continuous(range = c(2, 8), name = "Number") +
  ####  调整坐标轴扩展
  scale_y_continuous(expand = expansion(mult = c(0, 0))) +
  scale_x_continuous(expand = expansion(add = c(0, 0))) +
 #### 设置主题
  theme_void()

###  显示地图
print(p)
###  显示地图 改进后的版本
map_plot <- ggplot() +
#### 添加蓝色海洋背景
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90, 
           fill = "#cceeff", color = NA) +
####  绘制世界地图轮廓（浅灰色填充，灰色边框）
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#dedede", color = "gray60", size = 0.2) +
  
 ####  添加数据点（圆形，根据habitat着色，根据number调整大小）
  geom_point(data = data, aes(x = longitude, y = latitude, fill = habitat, size = number),
             shape = 21, alpha = 0.7, stroke = 0.5, color = "white") +
  
 ####  设置生境类型的颜色映射
  scale_fill_manual(values = habitat_colors, name = "生境类型") +
  
 ####  设置点大小范围
  scale_size_continuous(range = c(2, 8), name = "数量") +
  
  ####  设置坐标轴范围和标签
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
  
 ####  设置主题和样式
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
  
 ####  添加标题和副标题
  labs(
    title = "全球生境分布与数量可视化",
    subtitle = "数据来源: map-full.txt"
  )

#### 显示地图
print(map_plot)

####  保存地图为不同格式
save_path <- "C:/Users/17459/Desktop/"  
ggsave(paste0(save_path, "map_improved.pdf"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(paste0(save_path, "map_improved.png"), map_plot, width = 11, height = 5, dpi = 300)
ggsave(paste0(save_path, "map_improved.tif"), map_plot, width = 11, height = 5, dpi = 300)
