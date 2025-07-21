# Reads indels from a .csv files in which the
# first 4 columns are as in indel .csv files
# written by ICAMS.

read_indel_csv = function(filepath) {
  catalog = 
    read.csv(
      file = filepath,
      row.names = NULL, 
      check.names = FALSE)
  new_rownames = 
    paste(catalog$Type,
          catalog$Subtype, 
          catalog$Indel_size,
          catalog$Repeat_MH_size,
          sep ="_")
  rownames(catalog) = new_rownames
  catalog = as.matrix(catalog[ , -(1:4)]) 
  return(catalog)
}
