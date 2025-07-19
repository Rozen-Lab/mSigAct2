# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

mSigAct2 (mutational **Sig**nature **Act**ivity 2) is the development version of an R package for analyzing the "activities" of mutational signatures in genomic spectra. It uses maximum likelihood approaches to:

1. **Signature Presence Testing**: Conservatively estimate whether specific mutational signatures are present in a spectrum
2. **Sparse Assignment**: Determine a minimal subset of signatures needed to plausibly reconstruct an observed spectrum  
3. **MAP Assignment**: Maximum a posteriori estimation of signature activity using tumor-type-specific signature proportions

The package implements three main analysis workflows through key exported functions:
- `PresenceAttributeSigActivity()` - signature presence testing approach
- `SparseAssignActivity()` - sparse assignment approach  
- `MAPAssignActivity()` - MAP assignment approach

## Architecture

### Core Analysis Functions
- **MAPAssignActivity.R**: Main MAP assignment function for multiple spectra
- **MAPAssignActivity1.R**: MAP assignment for single spectrum  
- **SparseAssignActivity.R**: Sparse assignment for multiple spectra
- **PresenceAttributeSigActivity.R**: Signature presence testing approach

### Key Supporting Functions
- **LLHSpectrumMAP.R**, **LLHSpectrumMultinom.R**, **LLHSpectrumNegBinom.R**: Likelihood calculations using different probability distributions
- **ObjFnBinomMaxLH2.R**, **ObjFnMultinomMaxLH.R**: Objective functions for optimization
- **OptimizeExposure.R**: Core optimization routines
- **SignaturePresenceTest.R**: Statistical testing for signature presence
- **ForwardSearch.R**: Forward search algorithm implementation

### Utilities and Support
- **DefaultManyOpts.R**: Default optimization options
- **ExposureProportions.R**: Cancer-type-specific signature proportions
- **ShowSigActivity.R**, **AddSigActivity.R**: Visualization and results formatting
- **CalculateDistance.R**: Distance metrics between spectra and reconstructions

## Common Commands

### Package Development
```r
# Install package in development mode
devtools::install()

# Build package
devtools::build()

# Check package (equivalent to R CMD check)  
devtools::check()

# Run tests
devtools::test()
# or
testthat::test_check("mSigAct")

# Generate documentation
devtools::document()
```

### Testing
```r
# Run all tests
testthat::test_dir("tests/testthat")

# Run specific test file
testthat::test_file("tests/testthat/test_MAPAssignActivity.R")

# Run tests with long runtime (controlled by environment variable)
Sys.setenv("MSIGACT_TEST_LENGTH" = "long")
testthat::test_check("mSigAct")
```

### Continuous Integration
The package uses both GitHub Actions and AppVeyor for continuous integration:
- **GitHub Actions**: R CMD check on Windows (`.github/workflows/R-CMD-check.yaml`)
- **AppVeyor**: Additional Windows testing with BiocInstaller dependencies (`appveyor.yml`)

## Dependencies and Installation

### Key Dependencies
- **mSigTools** (>= 1.0.8): Signature analysis utilities  
- **PCAWG7** (>= 0.1.3): PCAWG7 data and utilities
- **cosmicsig**: COSMIC signature definitions
- **nloptr**: Nonlinear optimization

### Installation from GitHub
```r
# Development version (current working branch)
remotes::install_github(repo = "steverozen/mSigAct2", ref = "v3.0.3-branch")

# Install in development mode for local development
devtools::install()
```

## Key Concepts

### Mutation Types Supported
- **SBS96/SBS192/SBS1536**: Single base substitutions with different context sizes
- **DBS78**: Doublet base substitutions  
- **ID**: Insertion/deletion signatures

### Analysis Approaches
1. **Conservative Signature Presence**: Uses statistical testing to determine if signatures are present
2. **Sparse Assignment**: Deliberately biased toward using as few signatures as possible
3. **MAP Assignment**: Incorporates prior knowledge about signature frequencies in cancer types

### Parallel Processing
Functions support parallel processing via:
- `num.parallel.samples`: Number of samples to process in parallel
- `mc.cores.per.sample`: CPU cores per sample (uses mclapply internally)
- Automatically disabled on Windows systems

## File Structure Notes

- **R/**: Main package source code
- **data-raw/**: Development data, debugging scripts, and test cases for edge cases
- **tests/testthat/**: Automated test suite
- **inst/extdata/**: Package data files
- **man/**: Generated documentation (do not edit manually)

The extensive `data-raw/` directory contains debugging scripts and test cases for various edge cases and error conditions encountered during development, including:
- **errors/**: Debugging scripts for specific error conditions
- **loglh_two_model/**: Testing likelihood model comparisons
- **fs_error/**: Forward search algorithm debugging
- **multinomial/**: Multinomial likelihood testing

## Development Notes

### Current Branch Status
This is a development repository. The current working branch is `v3.0.3-branch`. All code should be considered experimental and subject to change.

### Debugging and Testing
Many functions contain extensive debugging capabilities controlled by environment variables and tracing options. The `data-raw/` directory contains real-world test cases that have been problematic during development.