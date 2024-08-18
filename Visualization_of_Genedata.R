#Load Libraries

library(ggplot2)
library(tidyverse)

#Basic Format for ggplot

dat.long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(.,aes(x = Samples, y = FPKM, fill = tissue)) +
  geom_col()
 
 #Density
dat.long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = FPKM, fill =  tissue)) +
  geom_density(alpha = 0.3)
   
#Bodl;hnjmx plot

dat.long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(.,aes(x = metastasis, y = FPKM)) +
  geom_boxplot()

#Scatter plot
dat.long %>%
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>%
  spread(key = gene, value = FPKM) %>%
  ggplot(., aes(x = BRCA1, y = BRCA2, colour = tissue)) +
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE)

#HEATMAP

genes.of.interest <- c('BRCA1', 'BRCA2', 'TP53', 'ALK', 'MYCN')

p <- dat.long %>% 
  filter(gene %in% genes.of.interest) %>%
  ggplot(., aes(x = Samples, y = gene, fill = FPKM)) +
  geom_tile() + scale_fill_gradient(low = 'white', high = 'red')

ggsave(p, filename = 'Heatmap_save1.pdf', width = 10, height = 8)
 
