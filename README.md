# Enforcement Policy in a Dynamic Model of Deterrence

**Replication Materials**

Clifford Bekar, Kenneth I. Carlaw, and B. Curtis Eaton

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Overview

This repository contains replication code for our paper on dynamic deterrence. We develop a model where agents form beliefs about apprehension probabilities through Bayesian learning, generating:

- **Quasi-attractors** with persistent high or low crime
- **Endogenous crime waves** and positive autocorrelation
- **Reserve capacity requirements** of 40-62% for cost-effective enforcement
- **Theoretical foundations** for empirically-observed crime persistence

**For complete documentation**, including all analytical proofs, benchmarking procedures, robustness tests, and detailed replication instructions, see **[Appendix 1 - Replication and Robustness](https://github.com/cliffbekar/dynamic_deterrence_policy/tree/main/%5B01%5D%20Appendix)**.

---

## Quick Start

### Installation

**Requirements:**
- Python 3.7+
- Jupyter Lab or Jupyter Notebook

**Install dependencies:**
```bash
pip install numpy scipy matplotlib numba quantecon statsmodels
```

**Matlab** code bases were produced with MATLAB R2024b under academic license

### Running Simulations

**Python/Jupyter Code:**
1. **Open the notebook**
```bash
jupyter lab Simulator.ipynb
```
2. **Set output paths** (lines 50-52 of notebook):
```python
path_data = "/your/path/to/data/"
path_code = "/your/path/to/code/"
path_figs = "/your/path/to/figures/"
```

3. **Run cells sequentially** to replicate all figures and tables

**Matlab Code:**
1. **Simulations run** in the default path(s) or active directory. 
2. **Use standard commands** "addpath" or "path" to change where the code is accessed and output sent 

---

## Repository Contents

- **`Python/Jupyter Code`**
  - Simulator.ipynb - Main replication code (Python/Jupyter)
- **`Matlab Code`**
  - EPDDmainconvFig1.m - main convergence code base for one-bin policies
  - EPDDbechCon.m      - convergence test using transition matrix produced by EPDDbenchTM.m
  - EPDDbenchTM.m      - produces transition matrix used in EPDDbechCon.m
  - EPDDsearch2Binv.m  - 2-bin policy search, $v^{(t-1)}$ proxy
  - EPDDsearch2BinAR.m - 2-bin policy search, $AR(t)$ proxy
  - EPDDsearch3Binv.m  - 3-bin policy search, $v^{(t-1)}$ proxy 
  - EPDDsearch#BinAR.m - 3-bin policy seaech, $AR(t)$ proxy
  - EPDD150MC2bin.m    - Monte Carlo routine 2-bin policy, $v^{(t-1)}$ proxy
  - EPDD150MC3bin.m    - Monte Carlo routine 3-bin policy, $v^{(t-1)}$ proxy
  - EPDDmainconvFig1.m    - produces Figure 1
  - EPDDattFig2.m         - produces Figure 2
  - EPDDpresistenceFig3.m - produces Figure 3
  - EPDDindexesFig4.m     - produces Figure 4
  - EPDDcostFig5.m        - produces Figure 5
  - EPDdattFig6.m         - produces Figure 6
  - EPDDattFig7.m         - produces Figure 7 (***see note below***)
  - EPDDHetg.m            - produces results in Section 3.1.1 of Appendix
  - EPDDHetq.m            - produces results in Section 3.1.2 of Appendix
  - EPDDexpApr.m          - produces results in Section 3.1.3 of Appendix
  - EPDDRF.m              - produces Appendix Figure 7
  - EPDDApFig8.m          - produces Appendix Figure 8
  - EPDDApFig9.m          - produces Appendix Figure 9
  - EPDDApFig10.m         - produces Appendix Figure 10
  - EPDDApFig11.m         - produces Appendix Figure 11
- **`Appendix_1_-_Replication_and_Robustness.pdf`** - Complete technical documentation
  - Section 1: Analytical proofs and computational methods
  - Section 2: Detailed replication instructions for all figures/tables
  - Section 3: Comprehensive robustness analysis
  - Section 4: Policy optimization algorithms and sensitivity tests

_Note: Figure 7 uses matrixes created using the code bases EPDDattFig2 (v30.mat and vv30.mat) and EPDDFig7 (vv57.mat). These are produced using very long sims in each code base. For v30.mat and vv30.mat the simulation was run 120M iterations. For vv57.mat the simulation was run for 145M iterations. In each case this requires setting the parameter Block to the appropriate size or repeatedly re-running the code for smaller Block sizes and loading and saving the array each time._

---
## Key Parameters (Baseline)

```python
N = 100          # Population of potential violators
z = 2            # History length (periods)
μ = 0.6          # Mean gain from violation
σ = 0.2          # Std dev of gain distribution
γ = 0.8          # Investigation success rate
F = 1.0          # Sanction/fine
α = 1, β = 0.25  # Bayesian priors
ρ = 2, λ = 5     # Enforcement cost, social cost multiplier
```

---

## Replicating Main Results

**All figure/table replication procedures are detailed in Appendix Section 2.**

### Main Text Figures

| Figure | Description | 
|--------|-------------|
| Figure 1 | Time series across R |
| Figure 2 | Quasi-attractor dynamics (R=39) |
| Figure 3 | Persistence and time allocation |
| Figure 4 | Observable indices |
| Figure 5 | Expected cost of ASB |
| Figure 6 | Dynamics at optimal R*=44 |
| Figure 7 | Two-bin policy performance |

### Appendix Materials

**Table A.1**: Benchmarking simulations (N=50, z=1) - ~2 hours for 1000 Monte Carlo runs

**Figures A.1-A.11**: Robustness tests - see Appendix Section 3 for details

---

## Computational Notes

**Convergence criterion:** Simulations run until frequency distribution stabilizes (TEST ≤ 0.01 for 5 consecutive blocks of 50,000 periods).

**Performance:** Code uses Numba JIT compilation for 20-100× speedup on core functions.

**Limitations:** For very high attractor persistence, convergence may require extended runtimes. See Appendix §1.2 for discussion.


---

## Documentation

### For detailed information, see the Appendix:

- **Mathematical proofs** → Appendix §1.1
- **Benchmarking methodology** → Appendix §1.2  
- **Policy search algorithms** → Appendix §1.3
- **Complete replication guide** → Appendix §2
- **Robustness to alternative assumptions** → Appendix §3.1
- **Parameter sensitivity analysis** → Appendix §3.2
- **Policy robustness tests** → Appendix §4

The appendix provides rigorous documentation of all methods, complete replication instructions, and extensive robustness analysis across model specifications and parameter values.

---

## Model Variants

The notebook includes several specifications tested for robustness:

1. **Alternative apprehension functions**
   - Baseline: `p = γ·min(1, R/v)`
   - Exponential: `p = γ·(1 - 1/ε^(R/v))`

2. **Heterogeneous agents**
   - Person-specific gain distributions
   - Individual reference groups (network effects)
   - Idiosyncratic subjective probabilities

3. **Policy types**
   - One-bin: Static enforcement R
   - Two-bin: R₁ if v_{t-1} ≤ BE, R₂ otherwise
   - Three-bin: R₁, R₂, R₃ based on two thresholds

See Appendix §3.1 for complete specifications and results.

---

## Citation

```bibtex
@article{bekar2026enforcement,
  title={Enforcement Policy in a Dynamic Model of Deterrence},
  author={Bekar, Clifford and Carlaw, Kenneth I. and Eaton, B. Curtis},
  journal={[Journal Name]},
  year={2026}
}
```

---

## Contact

- Clifford Bekar: bekar@lclark.edu
- Kenneth I. Carlaw: kenneth.carlaw@ubc.ca
- B. Curtis Eaton: eaton@ucalgary.ca

**Issues:** Please open a GitHub issue for questions about the code.

---

## License

MIT License - see [LICENSE](LICENSE) file for details.


MIT License - see [LICENSE](LICENSE) file for details.
