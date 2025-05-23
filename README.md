# 全球样本分布地图可视化项目
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
# 加载必要的包
library(maps)
library(ggplot2)
library(dplyr)

# 设置工作目录（根据实际情况修改）
setwd("C:/Users/17459/Documents")

# 读取数据
data <- read.delim("map-full.txt", header = T)

# 将habitat列转换为有序因子
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

# 获取世界地图数据
world <- map_data("world")

# 创建地图
p <- ggplot() +
  # 绘制世界地图背景
  geom_polygon(data = world, aes(x = long, y = lat, group = group), fill = "#dedede") +
  # 添加数据点
  geom_point(data = data, aes(x = longitude, y = latitude, fill = habitat, size = number), 
             shape = 21, alpha = 0.6) +
  # 设置颜色方案
  scale_fill_manual(
    values = c('#BDB9DA', "#80B0D2", '#8DD2C6', '#FA8071', "#B3DE69",
               "#D9D9D9", "#CCEBC5", "#FBCDE4", "#FCB461", "#BB80BC", "#FFEC6D"),
    name = "Habitat Type"
  ) +
  # 设置点大小范围
  scale_size_continuous(range = c(2, 8), name = "Number") +
  # 调整坐标轴扩展
  scale_y_continuous(expand = expansion(mult = c(0, 0))) +
  scale_x_continuous(expand = expansion(add = c(0, 0))) +
  # 设置主题
  theme_void()

# 显示地图
print(p)

# 保存结果
ggsave('map.pdf', p, width = 11, height = 5)
ggsave("C:/Users/17459/Desktop/test.png", plot = p)
