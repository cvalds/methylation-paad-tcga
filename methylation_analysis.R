# Load the libraries needed for this
library(TCGAbiolinks)
library(SummarizedExperiment)
library(dplyr)
library(ggplot2)

# lets define the CpG sites cuz last time my laptop doesn't like data
target_cpgs <- c(
    "cg20930114", "cg01554064", "cg02871659", "cg18279742", "cg15445000",
    "cg03013999", "cg19439043", "cg17288560", "cg24520381", "cg24483576",
    "cg19586165", "cg02944084", "cg16557858", "cg22833365", "cg04520704"
)

# Step 1: Query TCGA-PAAD methylation data after having read the documentation on Bioconductor
query <- GDCquery(
    project = "TCGA-PAAD",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Human Methylation 450",
    sample.type = c("Primary Tumor", "Solid Tissue Normal")
)

# Step 2: Extract barcodes and select the small sample subset
barcodes <- getResults(query)$cases
tumor_barcodes <- barcodes[grep("01A", barcodes)]
normal_barcodes <- barcodes[grep("11A", barcodes)]
selected_barcodes <- c(tumor_barcodes, normal_barcodes)

# Step 3: Filter query results to only the selected barcodes
query$results[[1]] <- query$results[[1]] %>%
    dplyr::filter(cases %in% selected_barcodes)

# Step 4: Download the data (part with most debugging)
GDCdownload(query)


# Step 5: Prepare SummarizedExperiment object (might have to force library for SesameData as that was a prior error)
data.met <- GDCprepare(query)

# Step 6: Extract beta values for the CpG sites to see how methylated they are
beta_matrix <- assay(data.met)
common_cpgs <- intersect(target_cpgs, rownames(beta_matrix))
beta_subset <- beta_matrix[common_cpgs, , drop = FALSE]

# Step 7: Get sample metadata (tumor/normal)
metadata <- colData(data.met)
sample_types <- metadata$shortLetterCode  # TP = Tumor, NT = Normal

# Step 8: At last, Build the tidy dataframe for plotting
df_meth <- data.frame(
    CpG = rep(rownames(beta_subset), each = ncol(beta_subset)),
    Sample = rep(colnames(beta_subset), times = nrow(beta_subset)),
    Beta = as.vector(beta_subset),
    Type = rep(sample_types, times = nrow(beta_subset))
)
#Step 9: some summary statistics

df_meth %>%
  group_by(CpG, Type) %>%
  summarise(mean_beta = mean(Beta, na.rm = TRUE),
            sd_beta = sd(Beta, na.rm = TRUE),
            .groups = 'drop')


# Step 10: simple Boxplot of beta values to finish off
ggplot(df_meth, aes(x = Type, y = Beta, fill = Type)) +
    geom_boxplot() +
    facet_wrap(~CpG, scales = "free_y") +
    theme_minimal() +
    labs(
        title = "Methylation Beta Values by Sample Type (TCGA-PAAD)",
        y = "Beta Value", x = "Sample Type"
    )

