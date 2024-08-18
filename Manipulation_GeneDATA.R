# Script to manipulate gene expression data
#read in the data


dat  <-read.csv(file="/Users/hetvichudasama/6310/Youtube-Geneexpression/GSE183947_fpkm.csv.gz") 
dim(dat)

#get metadata
library(GEOquery)
Sys.setenv("VROOM_CONNECTION_SIZE" =  131072 *1000 )
gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)

# Check the content of the loaded data
gse

metadata <- pData(phenoData(gse[[1]]))
head(metadata)

metadata.modified <- metadata  %>%
  select(1,10,11,17) %>% 
  rename(tissue = characteristics_ch1) %>% 
  rename(metastasis = characteristics_ch1.1) %>%
  mutate(tissue = gsub("tissue:","", tissue)) %>%
  mutate(metastasis = gsub("metastasis:","", metastasis)) 

head(dat)

# Reshaping the data

dat.long <- dat %>%
  rename(gene = X) %>%
  gather(key = "Samples", value = "FPKM", -gene)


  # Join dataframes - dat.long + metadata.modified
  
dat.long <- dat.long %>%
  left_join(metadata.modified, by = c("Samples" = "description"))


#Explore dats
dat.long %>%
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>%
  group_by(gene, tissue) %>%
  summarise(mean_FPKM = mean(FPKM),
            median_FPKM = median(FPKM)) %>%
 arrange(mean_FPKM)

head()



