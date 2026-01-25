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

**For complete documentation**, including all analytical proofs, benchmarking procedures, robustness tests, and detailed replication instructions, see **[Appendix_1_-_Replication_and_Robustness.pdf](Appendix_1_-_Replication_and_Robustness.pdf)**.

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

### Running Simulations

1. **Open the notebook:**
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

---

## Repository Contents

- **`Simulator.ipynb`** - Main replication code (Python/Jupyter)
- **`Appendix_1_-_Replication_and_Robustness.pdf`** - Complete technical documentation
  - Section 1: Analytical proofs and computational methods
  - Section 2: Detailed replication instructions for all figures/tables
  - Section 3: Comprehensive robustness analysis
  - Section 4: Policy optimization algorithms and sensitivity tests

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

| Figure | Description | Expected Runtime |
|--------|-------------|------------------|
| Figure 1 | Time series across R | ~5 minutes |
| Figure 2 | Quasi-attractor dynamics (R=39) | ~10 minutes |
| Figure 3 | Persistence and time allocation | ~30 minutes |
| Figure 4 | Observable indices | ~20 minutes |
| Figure 5 | Expected cost of ASB | ~25 minutes |
| Figure 6 | Dynamics at optimal R*=44 | ~10 minutes |
| Figure 7 | Two-bin policy performance | ~15 minutes |

### Appendix Materials

**Table A.1**: Benchmarking simulations (N=50, z=1) - ~2 hours for 1000 Monte Carlo runs

**Figures A.1-A.11**: Robustness tests - see Appendix Section 3 for details

---

## Computational Notes

**Convergence criterion:** Simulations run until frequency distribution stabilizes (TEST ≤ 0.01 for 5 consecutive blocks of 50,000 periods).

**Performance:** Code uses Numba JIT compilation for 20-100× speedup on core functions.

**Limitations:** For very high attractor persistence, convergence may require extended runtimes. See Appendix §1.2 for discussion.

**Hardware:** Tested on 2019 MacBook Pro (2.3 GHz 8-Core i9, 16GB RAM). Your runtimes may vary.

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
