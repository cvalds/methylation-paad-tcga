## My First Sample of R + Python Bioinformatics

## What was the goal??

Basically, I wanted to see how "methylated" some specific CpG sites are in pancreatic cancer tissue vs. normal pancreatic tissue. This was inspired by a 2021 paper I read (Zhu et al.) that identified **45 CpG sites** linked to pancreatic cancer risk. Of those, **16 were actually measured** in tumor vs. benign tissue (if I remember correctly).

> “Of the 45 CpGs, we were able to compare measured methylation of 16 in pancreatic tumor versus benign pancreatic tissue. Of them, six showed differentiated methylation.”  
> — Zhu et al., 2021 ([link](https://doi.org/10.1158/1055-9965.EPI-21-0400))

Rather than try to download every single CpG from the 450K+ array and then run the scripts on that full dataset (which would probably make my laptop start fuming), I just grabbed those 16 from the paper and used that as proof of concept.

## Tools I used

- `TCGAbiolinks` (R package) to get methylation data from TCGA-PAAD
- Some light Python for notes/checks, but mostly R
- Tissue types:
  - **Primary Tumor** = cancerous pancreas
  - **Solid Tissue Normal** = the "control" a.k.a. benign

Citations for TCGAbiolinks:

Colaprico A, Silva TC, Olsen C, Garofano L, Cava C, Garolini D, Sabedot T, Malta TM, Pagnotta SM, Castiglioni I, Ceccarelli M, Bontempi G, Noushmehr H (2015). “TCGAbiolinks: An R/Bioconductor package for integrative analysis of TCGA data.” Nucleic Acids Research. doi:10.1093/nar/gkv1507, http://doi.org/10.1093/nar/gkv1507.

Silva, C T, Colaprico, Antonio, Olsen, Catharina, D'Angelo, Fulvio, Bontempi, Gianluca, Ceccarelli, Michele, Noushmehr, Houtan (2016). “TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages.” F1000Research, 5.

Mounir, Mohamed, Lucchetta, Marta, Silva, C T, Olsen, Catharina, Bontempi, Gianluca, Chen, Xi, Noushmehr, Houtan, Colaprico, Antonio, Papaleo, Elena (2019). “New functionalities in the TCGAbiolinks package for the study and integration of cancer data from GDC and GTEx.” PLoS computational biology, 15(3), e1006701.

## But hold on, what is Methylation, and what is CpG??? what does “methylated” mean here?

Good self check. Methylation is measured using something called the **Beta value** — it ranges from 0 (unmethylated) to 1 (fully methylated). I used that to compare CpG sites between tumor and normal tissue. CpG is shorthand for 5'—C—phosphate—G—3.

Now how does that all work? Why does methylation matter in epigenetics, much less in finding cancer biomarkers?

Well, 

DNA methylation is a chemical modification that adds a methyl group (—CH₃) to the 5th carbon of cytosine in a CpG dinucleotide (where a cytosine is followed by a guanine). This forms 5-methylcytosine (5mC). The reaction is catalyzed by DNA methyltransferases (DNMT1, DNMT3A/B) using S-adenosylmethionine (SAM) as a methyl donor. These CpG sites, although relatively rare, are often clustered near gene promoters in regions called CpG islands. When cytosines in these areas are methylated, it physically interferes with transcription factor binding and also recruits methyl-binding proteins that attract chromatin-modifying enzymes (like histone deacetylases), resulting in condensed, transcriptionally silent chromatin.

This is how methylation directly regulates gene expression—it tightens the chromatin and shuts down access. But bear in mind, it’s not permanent. Methylation patterns can be reversed through active demethylation, particularly via TET enzymes, which oxidize 5mC into intermediates that are eventually removed and replaced with regular cytosine. This makes methylation a dynamic system: it shapes development, helps establish stable cell identities, and changes in response to environmental signals. In cancer, these patterns often go abnormally, genes are inappropriately silenced (like tumor suppressors), while others are activated due to global hypomethylation.

All in all, there isn't any real results to detract from this particular project, it's just a visualization of methylation in those specific 16 CpGs, as any sort of statistical analysis is left up in the air (I'd need far more data I think, I could do t-tests and stuff but I'd rather err on not making claims on things I have yet to fully understand).

## TL;DR

- Read paper → found 16 relevant CpG sites
- Used `TCGAbiolinks` to grab methylation Beta values from TCGA
- Organized them by sample type (tumor vs. normal)
- Plan: visualize, maybe correlate with gene expression later when I have better knowledge and tools
  
