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
 ####  制世界地图背景
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
#### 设置背景为白色
      panel.background = element_rect(fill = "white"),
      plot.background = element_rect(fill = "white", color = NA)
    ) +
####  添加分两行的黑色注释
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
  draw_plot(combined_plot, x = 0.05, x = 0.05, y = 0.08,, width = 0.9, height = 0.85) + 
  draw_label("Pseudotime", x = 0.5, y = 0.02, size = 14, fontface = "bold", vjust = 0) +  
  draw_label("Normalized Expression", x = 0.02, y = 0.5, size = 14, angle = 90, fontface = "bold", hjust = 0)  
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
# （四）Third-dose COVID-19 vaccine-induced immunity in individuals with severe obesity.
文献：Accelerated waning of the humoral response to COVID-19 vaccines in obesity，Fig. 4c: Third-dose COVID-19 vaccine-induced immunity in individuals with severe obesity.
## 代码解析
### 数据构建
mydata <- data.frame(
  id = c(1:12, 1:12),
  visit_times = c(rep("V3D28", 12), rep("V3D105", 12)),
  NT50 = c(820, 1160, 5315, 1528, 4010, 3540, 930, 2198, 1700, 940, 3570, 940,
           380, 1010, 5165, 1590, 2810, 1460, 900, 2320, 620, 430, 2690, 560))
### 载入 R 包
library(ggplot2)
加载ggplot2包，这是 R 语言中用于创建数据可视化图形的强大工具包，后续绘图将基于此包函数实现。
### 绘图操作
ggplot(mydata, aes(x = visit_times, y = NT50, group = id)) +
  geom_point(size = 1.5) + # 点
  geom_line(linetype = "dashed") + # 连接线
  geom_hline(yintercept = 10, linetype = "dotted") +
  scale_x_discrete(limits = c("V3D28", "V3D105")) +
  scale_y_log10(breaks = c(1, 10, 100, 1000, 10000, 100000), limits = c(1, 100000), # log10后的y轴
                expand = c(0, 0), labels = c("1", "10", "100", "1,000", "10,000", "100,000")) +
  theme_classic() +
  theme(plot.title = element_text(face = "bold", size = 16, hjust = -0.3),
        plot.subtitle = element_text(size = 14, hjust = 0.5),
        axis.text.x = element_text(size = 11),
        axis.line = element_line(linewidth = 0.2),
        legend.position = "none") +
  labs(title = "c",
       subtitle = "Normal BMI",
       x = "",
       y = expression("NT"["50"]))
   ### 具体说明
初始设置：以mydata为数据源，ggplot()函数设定x轴为visit_times ，y轴为NT50 ，并通过group = id将数据按个体分组，为后续绘图做准备。
添加图形元素
geom_point(size = 1.5)添加数据点，大小设为 1.5 ，在图中展示每个个体在不同访视时间的 NT50 值。
geom_line(linetype = "dashed")添加虚线连接各数据点，体现同一id个体在不同时间点 NT50 的变化趋势。
geom_hline(yintercept = 10, linetype = "dotted")添加水平虚线，y轴截距为 10 ，可能是作为参考线，用于判断 NT50 值与特定水平的关系。
坐标轴设置
scale_x_discrete(limits = c("V3D28", "V3D105"))设置x轴为离散型，展示的水平轴标签为 “V3D28” 和 “V3D105” 。
scale_y_log10(...)将y轴设为以 10 为底的对数刻度。指定刻度断点（breaks ）、范围（limits ） ，expand设为c(0, 0)使刻度范围紧密贴合数据，labels自定义刻度标签展示样式。
图形主题和标签设置
theme_classic()设定经典主题样式，去除不必要的图形背景元素。
theme(...)进一步微调主题，设置标题加粗、大小及水平位置（hjust ） ，副标题大小和水平位置，x轴文本大小，坐标轴线条宽度，移除图例。
labs(...)设置图形标题为 “c” ，副标题为 “Normal BMI” ，x轴无标签，y轴标签为 “NT50” ，其中expression()函数用于展示特殊格式文本。
# （五）Immune response to third (booster) dose COVID-19 vaccination
文献：Accelerated waning of the humoral response to COVID-19 vaccines in obesity，Fig. 3. Immune response to third (booster) dose COVID-19 vaccination. 
## 代码解析
这段代码使用 R 语言创建并绘制了一个热图，用于展示蛋白质表达数据在不同簇之间的分布情况，与文献中的 Fig. 3 免疫反应分析相关。
### 数据准备
 ####  调整图表位置和大小创建数据
set.seed(1288) # 让随机数据可重复
protein_expression <- matrix(runif(90), ncol = 5)

####  调整图表位置和大小修改列和行的名称
colnames(protein_expression) <- paste("Cluster", 1:5, sep = "")
rownames(protein_expression) <- paste("Protein", 1:18, sep = "")

 ####  调整图表位置和大小转化成matrix格式的数据
mydata <- as.matrix(protein_expression)

####  调整图表位置和大小标签变量
labs <- colnames(mydata)
set.seed(1288)：设置随机数种子，确保生成的随机数据可重复。
matrix(runif(90), ncol = 5)：生成一个 18 行 5 列的矩阵，包含 90 个均匀分布的随机数，模拟 18 种蛋白质在 5 个簇中的表达量。
列名设置为 "Cluster1" 到 "Cluster5"，行名设置为 "Protein1" 到 "Protein18"。
### 热图绘制
heatmap(mydata,
        ColSideColors = c("blueviolet", "orange1", "limegreen", "firebrick1", "dodgerblue3"),
        labCol = "", # 不显示列的label
        add.expr = text(x = seq_along(labs), y = -0.2, srt = 0, # 重新调整列标签的位置和角度
                        labels = labs, xpd = TRUE, cex = 1.5),
        cexRow = 1.5) # 行标签的字体大小
### 参数说明：
ColSideColors：为每列（簇）指定不同的颜色，用于区分 5 个簇。
labCol = ""：不显示默认的列标签。
add.expr：通过text()函数自定义列标签的位置和样式：
x = seq_along(labs)：标签位置沿 x 轴均匀分布。
y = -0.2：标签位于热图底部（y 坐标为负值）。
srt = 0：标签水平显示（旋转 0 度）。
cex = 1.5：标签字体大小为默认的 1.5 倍。
cexRow = 1.5：行标签（蛋白质名称）的字体大小为默认的 1.5 倍。
### 可视化效果
这个热图展示了 18 种蛋白质在 5 个簇中的表达情况：

颜色条（ColSideColors）直观地区分了不同的簇。
蛋白质名称显示在左侧，便于识别。
列标签（簇名称）位于热图底部，水平排列且字体较大，提高可读性。
# （六）雷达图绘制
来源：Liao H, Liu C, Zhou S, et al. Prophage-encoded antibiotic resistance genes are enriched in human-impacted environments. Nature Communications. 2024;15(1):8315. doi:10.1038/s41467-024-52450-y（补充文件图S8）
这段 R 代码主要用于读取多个文本文件中的数据，并使用ggradar包绘制雷达图展示不同类别数据的相关信息，最后将多个雷达图组合并保存。以下是详细的代码展示：
## 代码解析
### 加载所需的包
library(ggradar)
library(ggplot2)
library(gridExtra)

### 设置工作目录
setwd("D:/thisthis/2024-2025-2/exam/data/detection frequency")

### 读取各类数据文件
data.Aquatic.organism <- read.delim('Aquatic organism pARG detection frequency.txt', header = T)
data.food <- read.delim('food pARG detection frequency.txt', header = T)
data.huamn <- read.delim('human pARG detection frequency.txt', header = T)
data.Insects <- read.delim('insects pARG detection frequency.txt', header = T)
data.animal.husbandry <- read.delim('livetock pARG detection frequency.txt', header = T)
data.Plant <- read.delim('plant pARG detection frequency.txt', header = T)
data.Seawater <- read.delim('seawater pARG detection frequency.txt', header = T)
data.Sediment <- read.delim('sediments pARG detection frequency.txt', header = T)
data.soil <- read.delim('Soil pARG detection frequency.txt', header = T)
data.Wild.animal <- read.delim('wildlife pARG detection frequency.txt', header = T)
data.Surface.water <- read.delim('Fresh water pARG detection frequency.txt', header = T)

### 绘制food数据的雷达图
range(data.food[, 2:12])
p1 <- ggradar(plot.data = data.food,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#78A8C6")
)
p1
ggsave("food prophageARGs检出率.pdf", p1, width = 12, height = 8)

### 绘制animal.husbandry数据的雷达图
range(data.animal.husbandry[, 2:12])
p2 <- ggradar(plot.data = data.animal.husbandry,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#BEBADA")
)
p2
ggsave("animal.husbandry prophageARGs检出率.pdf", p2, width = 12, height = 8)

### 绘制huamn数据的雷达图
range(data.huamn[, 2:12])
p3 <- ggradar(plot.data = data.huamn,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#8DD3C7")
)
p3
ggsave("human prophageARGs检出率.pdf", p3, width = 12, height = 8)

### 绘制soil数据的雷达图
range(data.soil[, 2:12])
p4 <- ggradar(plot.data = data.soil,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#F37D74")
)
p4
ggsave("soil prophageARGs检出率.pdf", p4, width = 12, height = 8)

### 绘制Sediment数据的雷达图
range(data.Sediment[, 2:12])
p5 <- ggradar(plot.data = data.Sediment,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#BEE0BE")
)
p5
ggsave("Sediment prophageARGs检出率.pdf", p5, width = 12, height = 8)

### 绘制Wild.animal数据的雷达图
range(data.Wild.animal[, 2:12])
p6 <- ggradar(plot.data = data.Wild.animal,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#F5C2D9")
)
p6
ggsave("Wild.animal prophageARGs检出率.pdf", p6, width = 12, height = 8)

### 绘制Surface.water数据的雷达图
range(data.Surface.water[, 2:12])
p7 <- ggradar(plot.data = data.Surface.water,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#A0CE3A")
)
p7
ggsave("Surface.water prophageARGs检出率.pdf", p7, width = 12, height = 8)

### 绘制Aquatic.organism数据的雷达图
range(data.Aquatic.organism[, 2:12])
p8 <- ggradar(plot.data = data.Aquatic.organism,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#9D9E98")
)
p8
ggsave("Aquatic.organism prophageARGs检出率.pdf", p8, width = 12, height = 8)

### 绘制Insects数据的雷达图
range(data.Insects[, 2:12])
p9 <- ggradar(plot.data = data.Insects,
              grid.min = 0, 
              grid.mid = 0.5, 
              grid.max = 1,
              grid.label.size = 10,
              values.radar = c("0", "50%", "100%"),
              background.circle.colour = "#C7E6F0",
              fill = T,
              fill.alpha = 0.2,  
              group.line.width = 1, 
              group.point.size = 3,
              group.colours = c("#AA7CB6")
)
p9
ggsave("Insects prophageARGs检出率.pdf", p9, width = 12, height = 8)

### 绘制Seawater数据的雷达图
range(data.Seawater[, 2:12])
p10 <- ggradar(plot.data = data.Seawater,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0", "50%", "100%"),
               background.circle.colour = "#C7E6F0",
               fill = T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#F2E27B")
)
p10
ggsave("Seawater prophageARGs检出率.pdf", p10, width = 12, height = 8)

### 绘制Plant数据的雷达图
range(data.Plant[, 2:12])
p11 <- ggradar(plot.data = data.Plant,
               grid.min = 0, 
               grid.mid = 0.5, 
               grid.max = 1,
               grid.label.size = 10,
               values.radar = c("0", "50%", "100%"),
               background.circle.colour = "#C7E6F0",
               fill = T,
               fill.alpha = 0.2,  
               group.line.width = 1, 
               group.point.size = 3,
               group.colours = c("#D37A0F")
)
p11
ggsave("Plant prophageARGs检出率.pdf", p11, width = 12, height = 8)

### 组合所有雷达图
p <- grid.arrange(p3, p2, p1, p6, p7, p4, p8, p5, p11, p9, p10, ncol = 3, nrow = 4)
p
ggsave("检出率组合.pdf", p, width = 24, height = 18)
## 代码功能总结
数据读取：从指定工作目录中读取多个文本文件，文件内容与不同类别（如食物、人类、土壤等）的 pARG 检测频率相关。
雷达图绘制：针对每个数据集，使用ggradar函数绘制雷达图，设置了雷达图的网格范围、标签、背景颜色、填充颜色等参数，展示数据的分布情况。
图形保存：将每个单独的雷达图保存为 PDF 文件，最后将所有雷达图组合成一个布局，并保存为 “检出率组合.pdf” ，方便整体展示和对比不同类别的数据特征。

