# Function to translate DNA to protein
translate_dna_to_protein <- function(dna_sequence) {
  codon_table <- list(
    "ATA"="I", "ATC"="I", "ATT"="I", "ATG"="M",
    "ACA"="T", "ACC"="T", "ACG"="T", "ACT"="T",
    "AAC"="N", "AAT"="N", "AAA"="K", "AAG"="K",
    "AGC"="S", "AGT"="S", "AGA"="R", "AGG"="R",
    "CTA"="L", "CTC"="L", "CTG"="L", "CTT"="L",
    "CCA"="P", "CCC"="P", "CCG"="P", "CCT"="P",
    "CAC"="H", "CAT"="H", "CAA"="Q", "CAG"="Q",
    "CGA"="R", "CGC"="R", "CGG"="R", "CGT"="R",
    "GTA"="V", "GTC"="V", "GTG"="V", "GTT"="V",
    "GCA"="A", "GCC"="A", "GCG"="A", "GCT"="A",
    "GAC"="D", "GAT"="D", "GAA"="E", "GAG"="E",
    "GGA"="G", "GGC"="G", "GGG"="G", "GGT"="G",
    "TCA"="S", "TCC"="S", "TCG"="S", "TCT"="S",
    "TTC"="F", "TTT"="F", "TTA"="L", "TTG"="L",
    "TAC"="Y", "TAT"="Y", "TAA"="*", "TAG"="*",
    "TGC"="C", "TGT"="C", "TGA"="*", "TGG"="W"
  )
  protein <- ""
  for (i in seq(1, nchar(dna_sequence) - 2, by=3)) {
    codon <- toupper(substr(dna_sequence, i, i+2))
    aa <- codon_table[[codon]]
    if (is.null(aa)) aa <- "X"
    protein <- paste0(protein, aa)
  }
  return(protein)
}

# Function to simulate logistic growth with randomized lag and exponential phase
simulate_logistic_growth <- function(t_max = 100, K = 1, r = 0.2, N0 = 0.01) {
  lag_duration <- sample(5:15, 1)
  exp_duration <- sample(20:50, 1)
  t <- seq(0, t_max, by = 1)
  N <- numeric(length(t))
  
  for (i in seq_along(t)) {
    if (t[i] <= lag_duration) {
      N[i] <- N0
    } else if (t[i] <= lag_duration + exp_duration) {
      adjusted_time <- t[i] - lag_duration
      N[i] <- K / (1 + ((K - N0) / N0) * exp(-r * adjusted_time))
    } else {
      N[i] <- K
    }
  }
  return(data.frame(time = t, population density = N))
}

# Generate 100 different growth curves
generate_growth_curves <- function(n = 100) {
  curves <- lapply(1:n, function(i) {
    df <- simulate_logistic_growth()
    df$curve_id <- i
    return(df)
  })
  do.call(rbind, curves)
}

# Function to find time to reach 80% of carrying capacity
time_to_80_percent <- function(df) {
  K <- max(df$population density)
  threshold <- 0.8 * K
  df$time[which(df$population density >= threshold)[1]]
}

# Function to calculate Hamming distance
hamming_distance <- function(str1, str2) {
  max_len <- max(nchar(str1), nchar(str2))
  str1 <- sprintf(paste0("%-", max_len, "s"), str1)
  str2 <- sprintf(paste0("%-", max_len, "s"), str2)
  sum(substring(str1, 1:max_len, 1:max_len) != substring(str2, 1:max_len, 1:max_len))
}

# Example usage
growth_data <- generate_growth_curves()
hamming_distance("peace", "peace okunade")

# Stage one link https://github.com/Peaceoluwaseun/HackBioInternship/tree/main/stage%20one
