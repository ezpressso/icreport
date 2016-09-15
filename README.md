
The `icreport` package provides functions that perform independent component analysis on a given data set and can subsequently generate a compact report. 

### Important Note

Partial functionality of `icreport` has been moved over to `picaplot` which is going to be the public release with core features. `icreport` will remain on git, 
but the code is not as organized as `picaplot` and it also contains a lot of custom functions that were created on the fly for personal use. 
Please follow this link to access the `picaplot` package. (https://github.com/jinhyunju/picaplot)


### Running ICA on the expression dataset. 

1) Things that you need:

- phenotype.mx should be the expression matrix with genes in rows and samples in columns (dimension = genes x samples)

- info.df should be the sample information data frame with the covariates in columns (dimension = samples x covariates)

- check.covars should be a vector that contains the names of the covariates (column names of sample.info) that should be tested for associations with independent components. In this case we are testing all 5 covariates for associations.

- For information regarding other advanced options please use ```?gene_expr_ica```.

2) In case you have covariates:

```r
library(icreport)
ica_result <- gene_expr_ica(phenotype.mx = expr.data, 
                            info.df = sample.info,
                            check.covars = colnames(sample.info))

# This may also take a few minutes depending on the size of your dataset. 
```

3) In case you don't have any covariates:

```r
library(icreport)
ica_result <- gene_expr_ica(phenotype.mx = expr)

```

4) Creating a report file in the current working directory

- input should be the result generated by the ```gene_expr_ica()``` function.

- prefix specifies the name of the html report file. 

- geneinfo.df should be a dataframe that contains information about gene (or probe) positions. The column names should be "phenotype" for the genes or probes (rownames of expr.data), "pheno_chr" for chromosomes, "pheno_start" for starting coordinates and "pheno_end" for end coordinates. See example below for more details. 

```r

head(probe.info)

```

- You can specify the output directory by including the option output.path = "/path/to/directory". Please note that sometimes directories starting with the short cut for home "~" are not recognized, so I recommend setting the working directory to the desired output directory first or specifying the full path. 

```r
report2me(input = ica_result, 
          prefix = "Test_ICA_Report",
          geneinfo.df = probe.info)
```

### Running PCA on the expression dataset. 

The PCA functionality of the package runs ```prcomp()``` on the dataset, and also tests given covariates against the principal components.

1) In case you have covariates:

```r

pca_result <- gene_expr_pca(phenotype.mx = expr.data, 
                            info.df = sample.info,
                            check.covars = colnames(sample.info))

```

2) In case you don't have any covariates:

```r

pca_result <- gene_expr_pca(phenotype.mx = expr.data)

```

3) Generating a report:

- report2me automatically detects whether the inputs are ICA or PCA results and it will generate the correct report. 

- pca.result is the result generated by the ```gene_expr_pca()``` function.

- prefix specifies the name of the html report file. 

```r
report2me(input = pca_result, 
          prefix = "Test_PCA_Report",
          geneinfo.df = probe.info)
```


### Updated functions

* To do 

- [ ] Fix documentation

Restructuring old functions to make the functionalities more modular. 

Modular processes are:

1) Run PCA / ICA on data

2) Test association with covariates 

3) Plot individual components (also summary figures through functions)

4) Generate report 
 

```r

library(icreport)
h5file <- "testinput.h5"
data_prefix <- gsub("[.]h5", "",h5file)

create_h5_file(h5file)

h5_add_data(file_name = h5file,
            input_matrix = phenotypes,
            data_type = "phenotypes")

h5_add_data(file_name = h5file,
            input_matrix = genotypes,
            data_type = "genotypes",
            feature_ids = snp.info$id)

h5_add_data(file_name = h5file,
            input_matrix = covars,
            data_type = "covars")

h5_add_snp_info(file_name = h5file,
                snp_id = snp.info$id,
                snp_chr = snp.info$chrom,
                snp_pos = snp.info$position)

h5_add_pheno_info(file_name = h5file,
                  pheno_id = gene.info$ensembl,
                  pheno_chr = gene.info$chromosome,
                  pheno_start = gene.info$start,
                  pheno_end = gene.info$end,
                  pheno_entrez = gene.info$entrez,
                  pheno_symbol = gene.info$symbol)

ica_result <- h5_ica(h5_file = h5file,var.cutoff = 95)
ica_result <- ica_covar_check(ica_list = ica_result,h5_file = h5file)
ica_result <- ica_genotype_association(ica_list = ica_result, h5_file = h5file)
ica_result <- get_gene_info(ica_result, h5file)

ica_report(ica_result, h5_file = h5file, prefix = data_prefix, output.path = "./")

    
```
Special Thanks to: Sushila, Francisco, Monica, Priya, Adrian, and Jason B. for testing and feedback. 
