import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Load the dataset from the CSV file
df = pd.read_csv("methylation_beta_subset.csv")


print(df.head())
print(df['Type'].value_counts())
print(df['CpG'].nunique(), "unique CpGs")
print(df['Sample'].nunique(), "unique samples")

# another boxplot to visualize the distribution of beta values across CpGs
plt.figure(figsize=(14, 6))
sns.boxplot(data=df, x="CpG", y="Beta", hue="Type")
plt.title("Beta Value Distribution by CpG")
plt.xticks(rotation=90)
plt.tight_layout()
plt.show()

# Create a pivot table for heatmap
pivot_df = df.pivot_table(index='CpG', columns='Sample', values='Beta', aggfunc='mean') 

# and a simple heatmap to visualize the methylation levels across samples
sns.clustermap(pivot_df.fillna(0), cmap="vlag", metric="euclidean", figsize=(12, 10))
plt.title("Heatmap of CpG Methylation Across Samples")
plt.show()

#summary statistics for beta values by CpG and Type
summary_df = df.groupby(["CpG", "Type"])["Beta"].agg(['count', 'mean', 'std', 'min', 'max']).reset_index()
print(summary_df.head())
