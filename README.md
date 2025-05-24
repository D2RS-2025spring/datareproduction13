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

# （二）食蟹猴体内 TRBV9+ T 细胞的耗竭效果
文献：Targeted depletion of TRBV9+ T cells as immunotherapy in a patient with ankylosing spondylitis，Extended Data Fig. 1 TRBV9+ T cell depletion in monkeys.
这段代码用于生成箱线图，展示不同剂量免疫治疗对食蟹猴体内 TRBV9+ T 细胞的耗竭效果。图表对比了雌性和雄性受试者的差异。
## 代码详情
### 需提前安装，install.packages("ggplot2")
library(ggplot2)

### 构建数据框
mydata <- data.frame(
  sex = c(rep("female", 19), rep("male", 20)),
  dose = c(rep("control", 5), rep("3 mg/kg", 4), rep("10 mg/kg", 5), rep("30 mg/kg", 5),
           rep("control", 5), rep("3 mg/kg", 5), rep("10 mg/kg", 4), rep("30 mg/kg", 6)),
  values = c(113.5, 113.5, 82.7, 120.9, 106.5, 11, 5.8, 23.4, 10.3, 5.1, 16,
             10.3, 7.5, 8.5, 5.8, 7.1, 12.5, 16, 15, 113.5, 93.9, 100, 88.1,
             93.9, 12.5, 11, 5.1, 4.3, 9.1, 8.5, 13.3, 11.7, 5.1, 8.5, 11,
             8, 22, 23.4, 5.8))

### 查看数据
head(mydata); tail(mydata)

### 绘制箱线图
ggplot(mydata, aes(x = dose, y = values, colour = sex, fill = sex)) +
  geom_boxplot(outlier.shape = NA, linewidth = 0.4) +
  geom_point(size = 1, position = position_jitterdodge(0.11)) +
  scale_x_discrete(limits = c("control", "3 mg/kg", "10 mg/kg", "30 mg/kg")) +
  scale_y_continuous(limits = c(0, 150), breaks = seq(0, 150, 25)) +
  scale_fill_manual(values = alpha(c("#E19841", "#50A87C"), 0.3)) +
  scale_colour_manual(values = c("#E19841", "#50A87C")) +
  annotate("segment", x = 1, xend = 2, y = 149, yend = 149) +
  annotate("segment", x = 1, xend = 3, y = 138.5, yend = 138.5) +
  annotate("segment", x = 1, xend = 4, y = 127, yend = 127) +
  annotate("text", x = 1.5, y = 150, size = 5, label = "***") +
  annotate("text", x = 2, y = 139.5, size = 5, label = "***") +
  annotate("text", x = 2.5, y = 128, size = 5, label = "***") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.65),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.margin = margin(20, 20, 20, 20)) +
  labs(x = "剂量",
       y = "标准化TRBV9 \n 比例, RT-PCR",
       fill = "",
       colour = "")
# （三）基因表达与伪时间轨迹的相关性分析及显著性
来源：Lee E. Korshoj & Tammy Kielian. (2024). Bacterial single-cell RNA sequencing captures biofilm transcriptional heterogeneity and differential responses to immune pressure. Nature Communications, 15(1), 10184-10184. DOI:10.1038/s41467-024-54581-8
## 代码详情
### 加载必要的包
if (!requireNamespace("openxlsx", quietly = TRUE)) install.packages("openxlsx") 
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2") 
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr") 
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr") 
if (!requireNamespace("cowplot", quietly = TRUE)) install.packages("cowplot") 

library(openxlsx)
library(ggplot2)
library(tidyr)
library(dplyr)
library(cowplot)

### 读取Excel数据
data <- read.xlsx("C:/Users/11443/Desktop/41467_2024_54581_MOESM22_ESM(1).xlsx", 
                  sheet = "Figure 3F")

### 长格式转换
data_long <- pivot_longer(data, 
                         cols = -Pseudotime, 
                         names_to = "Gene", 
                         values_to = "Expression")

### 定义基因顺序和颜色
gene_order <- c("psmβ1", "esaG", "aroB", "dnaA", "pgk", "rpoB")
gene_colors <- c("psmβ1" = "red", "esaG" = "red", "aroB" = "red", 
                 "dnaA" = "blue", "pgk" = "blue", "rpoB" = "blue")
data_long$Gene <- factor(data_long$Gene, levels = gene_order)

### 计算相关系数和p值
calculate_cor <- function(gene) {
  model <- lm(Expression ~ Pseudotime, data = data_long[data_long$Gene == gene, ])
  r <- cor(data_long[data_long$Gene == gene, c("Pseudotime", "Expression")])[1,2] 
  p_value <- summary(model)$coefficients[2,4]
  return(c(r = r, p_value = p_value))
}
results <- sapply(gene_order, calculate_cor, simplify = "data.frame") %>% t() %>% as.data.frame() 
results$Gene <- gene_order
results$Gene <- factor(results$Gene, levels = gene_order)

### 格式化p值并生成两行注释
results$p_value_formatted <- ifelse(results$p_value < 1e-300, "<1.0E-300", sprintf("%.3e", results$p_value))
results$annotations <- with(results, {
  paste0(Gene, "\nr=", sprintf("%.3f", r), "\np-value=", p_value_formatted)
})

### 创建单个基因的图形函数
create_gene_plot <- function(gene_name) {
  gene_data <- data_long %>% filter(Gene == gene_name)
  annotation_text <- results %>% filter(Gene == gene_name) %>% pull(annotations)
  
  ### 判断是否为最后一个基因（显示x轴）
  show_x_axis <- gene_name == gene_order[length(gene_order)]
  
  p <- ggplot(gene_data, aes(x = Pseudotime, y = Expression)) +
    geom_line(aes(color = Gene), linewidth = 1.2) +
    scale_color_manual(values = gene_colors[gene_name]) +
    theme_bw() +
    labs(x = "", y = "") +
    theme(
      legend.position = "none",
      panel.grid = element_blank(),
      panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
      panel.spacing = unit(0, "lines"),  # 图间无间距
      plot.margin = unit(c(0.05, 0.1, 0.05, 0.1), "inches"),  # 图内边距
      axis.title = element_blank(),
      axis.text = element_text(size = 10, color = "black"),
      axis.text.x = if(show_x_axis) element_text(angle = 45, hjust = 1, size = 10) else element_blank(),
      axis.ticks.length = unit(0.15, "cm"),
      strip.background = element_blank(),
      strip.text = element_blank(),
      ## 设置背景为白色
      panel.background = element_rect(fill = "white"),
      plot.background = element_rect(fill = "white", color = NA)
    ) +
    ## 添加分两行的黑色注释
    annotate("text", 
             x = max(gene_data$Pseudotime) * 0.95, 
             y = max(gene_data$Expression) * 0.95, 
             label = annotation_text, 
             hjust = 1, 
             vjust = 1, 
             size = 3.5, 
             color = "black",
             lineheight = 0.8)
  
  return(p)
}

### 创建所有基因的图形列表
gene_plots <- lapply(gene_order, create_gene_plot)

### 组合图形（无间距，共用y轴）
combined_plot <- plot_grid(plotlist = gene_plots, ncol = 1, align = "v", axis = "l", 
                          rel_heights = rep(1, length(gene_order)), 
                          scale = 1,  # 不缩放图形
                          byrow = TRUE)

### 添加共同的x轴和y轴标签（恢复原有间距）
final_plot <- ggdraw() +
  draw_plot(combined_plot, x = 0.05, x = 0.05, y = 0.08,, width = 0.9, height = 0.85) +  # 调整图表位置和大小
  draw_label("Pseudotime", x = 0.5, y = 0.02, size = 14, fontface = "bold", vjust = 0) +  # 调整x轴标签位置
  draw_label("Normalized Expression", x = 0.02, y = 0.5, size = 14, angle = 90, fontface = "bold", hjust = 0)  # 调整y轴标签位置
 ### 显示最终图形
print(final_plot) 

### 保存图形（调整高度以适应内容）
ggsave("combined_gene_plots（6）.png", final_plot, width = 8, height = 10, dpi = 300)
## 代码说明
加载包：检查并加载所需的 R 包，包括用于读取 Excel 文件的openxlsx、绘图的ggplot2、数据重塑的tidyr、数据处理的dplyr以及图形组合的cowplot。
数据读取与处理：从指定 Excel 文件的 “Figure 3F” 工作表读取数据，然后将数据从宽格式转换为长格式，方便后续分析和绘图。
基因设置：定义基因的顺序和颜色，将基因列转换为因子，确保绘图时基因按指定顺序呈现。
相关性计算：编写函数计算每个基因的表达量与伪时间轨迹之间的相关系数和 p 值，并将结果整理成数据框。
图形绘制：创建绘制单个基因图形的函数，设置图形的样式、注释等；然后循环绘制所有基因的图形，并将它们组合成一个多图，最后添加共用的坐标轴标签，得到最终图形并保存。
