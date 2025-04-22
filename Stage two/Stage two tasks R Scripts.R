
# MICROBIOLOGY TASK

# Load data
data <- read.table("https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/mcgc.tsv", sep = "\t", header = TRUE)

# Plot OD600 vs Time for each strain, overlaid + and - mutants
unique_strains <- unique(data$Strain)
par(mfrow = c(ceiling(length(unique_strains)/2), 2))
for (strain in unique_strains) {
  strain_data <- subset(data, Strain == strain)
  plot(NA, xlim = range(strain_data$Time), ylim = range(strain_data$OD600),
       xlab = 'Time', ylab = 'OD600', main = strain)
  lines(subset(strain_data, Mutant == '+')[, c('Time', 'OD600')], col = 'blue')
  lines(subset(strain_data, Mutant == '-')[, c('Time', 'OD600')], col = 'red')
  legend("topleft", legend = c("Knock-In (+)", "Knock-Out (-)"), col = c("blue", "red"), lty = 1, cex = 0.7)
}

# Estimate time to carrying capacity using simple smoothing
estimate_time_to_carrying_capacity <- function(time, od) {
  threshold <- max(od, na.rm = TRUE) * 0.8
  idx <- which(od >= threshold)[1]
  if (!is.na(idx)) return(time[idx]) else return(NA)
}

# Calculate for each group
times <- aggregate(OD600 ~ Strain + Mutant, data, function(od) {
  time <- data$Time[data$Strain == unique(data$Strain) & data$Mutant == unique(data$Mutant)]
  estimate_time_to_carrying_capacity(time, od)
})
names(times)[3] <- "TimeToCC"

# Box plot
boxplot(TimeToCC ~ Mutant, data = times, col = c("red", "blue"),
        main = "Time to Carrying Capacity", ylab = "Time")

# Scatter plot
plot(times$Strain[times$Mutant == "-"], times$TimeToCC[times$Mutant == "-"],
     col = "red", pch = 16, xlab = "Strain", ylab = "Time to CC", main = "Scatter: KO vs KI")
points(times$Strain[times$Mutant == "+"], times$TimeToCC[times$Mutant == "+"], col = "blue", pch = 17)
legend("bottomright", legend = c("KO", "KI"), col = c("red", "blue"), pch = c(16,17))

# T-test
ko <- times$TimeToCC[times$Mutant == "-"]
ki <- times$TimeToCC[times$Mutant == "+"]
t_test_result <- t.test(ko, ki)
print(t_test_result)

# Observation: If p-value < 0.05, there's significant difference in KO vs KI



# -------------------------------------------------------
# BIOCHEMISTRY & ONCOLOGY TASK

# Load datasets
sift <- read.table("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/sift.tsv", sep = "\t", header = TRUE)
foldx <- read.table("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/foldX.tsv", sep = "\t", header = TRUE)

# Create combined ID
sift$specific_Protein_aa <- paste(sift$Protein, sift$Amino_acid, sep = "_")
foldx$specific_Protein_aa <- paste(foldx$Protein, foldx$Amino_acid, sep = "_")

# Merge
merged <- merge(sift, foldx, by = "specific_Protein_aa")

# Filter deleterious
harmful <- subset(merged, SIFT_score < 0.05 & FoldX_score > 2)

# Get first amino acid
harmful$First_AA <- substr(harmful$Amino_acid.x, 1, 1)

# Frequency table
freq <- table(harmful$First_AA)

# Bar plot
barplot(freq, col = rainbow(length(freq)), main = "Amino Acid Impact Frequency")

# Pie chart
pie(freq, col = rainbow(length(freq)), main = "Amino Acid Impact Distribution")




# -------------------------------------------------------
# PUBLIC HEALTH TASK

# Load NHANES
nhanes <- read.csv("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/nhanes.csv")

# Handle NAs by converting to 0
nhanes[is.na(nhanes)] <- 0

# Histograms
hist(nhanes$BMI, main = "BMI Distribution", col = "green", xlab = "BMI")
hist(nhanes$Weight, main = "Weight Distribution", col = "blue", xlab = "Weight (kg)")
hist(nhanes$Weight * 2.2, main = "Weight in Pounds", col = "purple", xlab = "Weight (lbs)")
hist(nhanes$Age, main = "Age Distribution", col = "orange", xlab = "Age")

# Summary stats
mean_pulse <- mean(nhanes$Pulse, na.rm = TRUE)
bp_range <- range(nhanes$Diastolic, na.rm = TRUE)
income_var <- var(nhanes$Income, na.rm = TRUE)
income_sd <- sd(nhanes$Income, na.rm = TRUE)

# Scatter plots
plot(nhanes$Height, nhanes$Weight, col = as.factor(nhanes$Gender), pch = 19,
     main = "Height vs Weight by Gender", xlab = "Height", ylab = "Weight")
legend("topleft", legend = levels(as.factor(nhanes$Gender)), col = 1:length(unique(nhanes$Gender)), pch = 19)

# T-tests
tt1 <- t.test(Age ~ Gender, data = nhanes)
tt2 <- t.test(BMI ~ Diabetes, data = nhanes)
tt3 <- t.test(Alcohol_Year ~ Relationship_Status, data = nhanes)
tt1; tt2; tt3

#link: https://github.com/Peaceoluwaseun/HackBioInternship/tree/main/Stage%20two
