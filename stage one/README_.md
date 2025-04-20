Stage-one R Script
# Population Growth and Bioinformatics Functions in R

1. `translate_dna_to_protein(dna_sequence)`: Translates a DNA sequence into a protein string.
2. `simulate_logistic_growth(t_max, K, r, N0)`: Simulates a logistic growth curve with random lag and exponential phases.
3. `generate_growth_curves(n)`: Generates `n` growth curves using the above simulation.
4. `time_to_80_percent(df)`: Calculates the time to reach 80% of the carrying capacity (maximum population).
5. `hamming_distance(str1, str2)`: Computes the Hamming distance between two strings.

## Usage Example

```r
source("growth_analysis.R")

# Translate DNA
translate_dna_to_protein("ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG")

# Simulate and generate 100 growth curves
growth_data <- generate_growth_curves()

# Determine time to 80% of max growth for one curve
time_to_80_percent(subset(growth_data, curve_id == 1))

# Hamming distance between Slack username and Twitter handle
hamming_distance("peace", "peace okunade")
```


