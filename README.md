# Wheel diffvg

A Wheel built through Github Actions

[![Wheel Image Build](https://github.com/xiaoyao9184/wheel-diffvg/actions/workflows/wheel-build.yml/badge.svg)](https://github.com/xiaoyao9184/wheel-diffvg/actions/workflows/wheel-build.yml)

# Why

The original project [diffvg](https://github.com/BachiLi/diffvg) does not provide official wheel packages.

While searching for existing builds, I found several wheels targeting specific environments:

- [Diffvg Wheel of Python 3.10 + PyTorch 2.6.0 + CUDA 12.4](https://github.com/Prgckwb/diffvg)
- [Diffvg Wheel of Python 3.10 + PyTorch 2.4.0 + CUDA 12.4 for Windows](https://github.com/benbaker76/diffvg)
- [Diffvg Wheel of Python 3.10 + CUDA 11.8 for Windows](https://huggingface.co/Nekochu/Models/tree/main)

However, these builds only target specific environment combinations and do not cover many other versions of Python / PyTorch / CUDA.

Therefore, I created this project to automatically build diffvg wheels for different environments.

# Goal

This project uses GitHub Actions and GitHub Releases to automatically build and publish diffvg wheels.

The goal is to keep the build pipeline simple and reproducible, avoiding complex custom configuration whenever possible.

# Versioning

The upstream diffvg project has not been actively updated recently, while several forks contain fixes for build issues.

This repository therefore:

- Includes diffvg as a git submodule
- Keeps the package version aligned with upstream when possible
- Builds different wheels for different CUDA environments

The wheel filename reflects the build environment rather than changing the Python package version.

## Release versions

### 0.0.1

- Built from the original upstream repository:  
  https://github.com/BachiLi/diffvg
- Maintains the same package version as upstream
- Provides wheels Python<=3.10 for multiple CUDA<=12 environments

### 0.2.0

- Built from the fork:  
  https://github.com/Hemistone/diffvg
- This fork includes fixes that allow building with **CUDA 13**
- Wheels generated in this release support Python>=3.11 and CUDA 13 environments

# Releases

The wheels built by this project are published in the repository releases:

https://github.com/xiaoyao9184/wheel-diffvg/releases
