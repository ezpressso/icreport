% Generated by roxygen2 (4.0.2): do not edit by hand
\name{h5_add_pheno_info}
\alias{h5_add_pheno_info}
\title{Adding gene information to an HDF5 file}
\usage{
h5_add_pheno_info(file_name = NULL, pheno_id = NULL, pheno_chr = NULL,
  pheno_start = NULL, pheno_end = NULL, pheno_entrez = NULL,
  pheno_symbol = NULL)
}
\arguments{
\item{file_name}{Name of the HDF5 file to add the information to}

\item{gene_info}{Dataframe with gene information for all genes present in genotypes/matrix}

\item{id_col}{Column name of gene_info that contains id information}

\item{chr_col}{Column name of gene_info that contains chromosome information}

\item{start_col}{Column name of gene_info that contains start positions}

\item{end_col}{Column name of gene_info that contains end positions}

\item{entrez_col}{Column name of gene_info that contains entrez ids}

\item{symbol_col}{Column name of gene_info that contains gene symbols}
}
\value{
Saves the given objects into the hdf5 generated by the create_eqtl_input_h5() function.
}
\description{
Use in-memory objects to add gene information to a given HDF5 file
}
\keyword{HDF5}
\keyword{eQTL,}

