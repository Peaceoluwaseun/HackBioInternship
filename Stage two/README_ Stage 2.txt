
# README - HackBio Internship Tasks (R Language)

## Overview
This document contains R scripts for the HackBio Internship 2025 tasks in the domains of Microbiology, Biochemistry & Oncology, and Public Health. All scripts use **base R** functions for maximum compatibility with online platforms like the HackBio website.

---

## Microbiology
**Dataset**: mcgc.tsv  
**Link**: https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/mcgc.tsv

### Tasks:
1. Plot growth curves (OD600 vs Time) for all strains with knock-out (-) and knock-in (+) overlays.
2. Use a logistic growth-like estimation function to determine the time to reach carrying capacity.
3. Generate scatter and box plots for time-to-carrying-capacity comparisons between strains.
4. Check for statistical significance in growth differences.

---

## Biochemistry & Oncology
**Datasets**: 
- SIFT: https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/sift.tsv
- FoldX: https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/foldX.tsv

### Tasks:
1. Merge datasets using a combined identifier `specific_Protein_aa`.
2. Identify deleterious mutations using SIFT < 0.05 and FoldX > 2 criteria.
3. Generate frequency tables, barplots, and pie charts for amino acid mutations.
4. Report the most frequent amino acids affecting both structure and function.

---

## Public Health
**Dataset**: NHANES  
**Link**: https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/nhanes.csv

### Tasks:
1. Clean dataset by handling NA values.
2. Visualize BMI, Weight, Pounds, and Age distributions.
3. Compute summary statistics (mean pulse, blood pressure range, income variance).
4. Visualize weight-height relationship.
5. Conduct t-tests between variables (e.g., Age vs Gender, BMI vs Diabetes).

---

## How to Use
1. Copy the script from `hackbio_tasks_r.R` into your RStudio or HackBio coding environment.
2. Ensure you have an internet connection to load datasets from URLs.
3. Run each section independently.

---

## Notes
- All code is written in base R to prevent errors on web-based interpreters.
- For any plot to render, ensure your plotting device is active (e.g., RStudio plot window).

---

Happy Hacking 💻🔬📊
