library(Rcpi)
mol_drug = readMolFromSDF("Drug_List.sdf")

##Klekota and Roth.4860 digits

fp_KR = extractDrugKRComplete(mol_drug)
n <- length(mol_drug)
simi_KR = matrix(1,n,n)
for (i in 2:n)
{
  for (j in 1:(i-1))
  {
    simi_KR[i,j] = simi_KR[j,i] <- calcDrugFPSim(fp_KR[i,], fp_KR[j,], fptype = "complete", metric = "tanimoto")
  }
}

row.names(simi_KR) = colnames(simi_KR) <- as.matrix(read.table("Drug_List.txt"))
write.table(simi_KR,"simi_KR.txt",quote = F, sep = "\t")

##Calculate the E-State Molecular Fingerprints, 79 bits

fp_Estate = extractDrugEstateComplete(mol_drug)
simi_Estate = matrix(1,n,n)
for (i in 2:n)
{
  for (j in 1:(i-1))
  {
    simi_Estate[i,j] = simi_Estate[j,i] <- calcDrugFPSim(fp_Estate[i,], fp_Estate[j,], fptype = "complete", metric = "tanimoto")
  }
}

row.names(simi_Estate) = colnames(simi_Estate) <- as.matrix(read.table("Drug_List.txt"))
write.table(simi_Estate,"simi_Estate.txt",quote = F, sep = "\t")

##Calculate the hybridization molecular fingerprints, 1024 bits

fp_Hybridization = extractDrugHybridizationComplete(mol_drug)
simi_Hybridization = matrix(1,n,n)
for (i in 2:n)
{
  for (j in 1:(i-1))
  {
    simi_Hybridization[i,j] = simi_Hybridization[j,i] <- calcDrugFPSim(fp_Hybridization[i,], fp_Hybridization[j,], fptype = "complete", metric = "tanimoto")
  }
}

row.names(simi_Hybridization) = colnames(simi_Hybridization) <- as.matrix(read.table("Drug_List.txt"))
write.table(simi_Hybridization,"simi_Hybridization.txt",quote = F, sep = "\t")

##Calculate the MACCS molecular fingerprints, 166 bits

fp_MACCS = extractDrugMACCSComplete(mol_drug)
simi_MACCS = matrix(1,n,n)
for (i in 2:n)
{
  for (j in 1:(i-1))
  {
    simi_MACCS[i,j] = simi_MACCS[j,i] <- calcDrugFPSim(fp_MACCS[i,], fp_MACCS[j,], fptype = "complete", metric = "tanimoto")
  }
}

row.names(simi_MACCS) = colnames(simi_MACCS) <- as.matrix(read.table("Drug_List.txt"))
write.table(simi_MACCS,"simi_MACCS.txt",quote = F, sep = "\t")
