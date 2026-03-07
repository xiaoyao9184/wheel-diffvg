# Wheel diffvg

A Wheel built through Github Actions

[![Wheel Image Build](https://github.com/xiaoyao9184/wheel-diffvg/actions/workflows/wheel-build.yml/badge.svg)](https://github.com/xiaoyao9184/wheel-diffvg/actions/workflows/wheel-build.yml)


# Why

The original project [diffvg](https://github.com/BachiLi/diffvg) does not provide official wheel packages.

While searching for existing builds, I found several wheels targeting specific environments:

- [Diffvg Wheel of Python 3.10 + PyTorch 2.6.0 + CUDA 12.4](https://github.com/Prgckwb/diffvg)
- [Diffvg Wheel of Python 3.10 + PyTorch 2.4.0 + CUDA 12.4 for Windows](https://github.com/benbaker76/diffvg)
- [Diffvg Wheel of Python 3.10 + CUDA 11.8 for Windows](https://huggingface.co/Nekochu/Models/tree/main)

However, these builds do not cover many other version combinations (Python / PyTorch / CUDA).
Therefore I created this project to automatically build diffvg wheels for different environments.


# Goal

This project uses GitHub Actions and GitHub Releases to automatically build and publish diffvg wheels.

The goal is to keep the build pipeline simple and reproducible, avoiding complex custom configuration whenever possible.


# Versioning

The upstream diffvg project has not been actively updated recently, while several forks contain fixes for build issues.

This repository therefore:
- Includes diffvg as a git submodule
- Keeps the package version as 0.0.1 (same as upstream)
- Builds different wheels for different CUDA environments

The wheel filename reflects the build environment rather than changing the Python package version.

The build of this project will be published to Wheel under the repository releases [xiaoyao9184/diffvg](https://github.com/xiaoyao9184/wheel-diffvg/releases).
