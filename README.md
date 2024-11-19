# 🚀 Tutorial: Running GIZMO with MUSIC 🛠️

This tutorial provides a step-by-step guide to setting up and running cosmological simulations using **GIZMO** (a versatile astrophysical simulation code) with **MUSIC** (Multiscale Initial Conditions Generator).

---

## 🗂️ Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#cluster setup)
3. [Installation](#installation)
   - [Installing MUSIC](#installing-music)
   - [Installing GIZMO](#installing-gizmo)
4. [Generating Initial Conditions with MUSIC](#generating-initial-conditions-with-music)
5. [Running GIZMO](#running-gizmo)
6. [Troubleshooting](#troubleshooting)
7. [References](#references)

---

## 📚 Introduction

**GIZMO** is a robust astrophysical simulation code capable of performing hydrodynamic, cosmological, and gravitational N-body simulations. **MUSIC** is used to generate the initial conditions for cosmological simulations, setting up the required density and velocity fields.

This guide will walk you through the process of:
- Setting up GIZMO+MUSIC on any available clusters
- Setting up MUSIC to generate initial conditions.
- Configuring GIZMO to run simulations using these initial conditions.

### 🤖 Note on automated setup
Instead of having to manually git clone the repos and go through all the tedious
steps, described below, I have a repository which basically allows plug-and-play
set up of GIZMO, STARFORGE, MUSIC, PeakPatch, Rockstar, and Grackle codes on any 
cluster. So if you need to get the stuff done fast, can just check it out
on my [GitHub](https://github.com/Vasissualiyp/GIZMO-setup). The guide below is
if you want to understand what is happening under the hood and if you want
to have full control over the proccess of your simulation setup.

---

## 🖥 **Cluster Setup**

Generally, before you run/compile anything, you should load required modules (i.e. compilers, FFTW, HDF5, etc.), and set some machine-specific settings. Below are such preparations for all machines I worked on as for November 2024:
- [Setting up on Niagara](docs/niagara_setup.md)
- [Setting up on CITA Cluster](docs/cita_setup.md)
- [Setting up on CITA Starq Cluster](docs/starq_setup.md)
- [Setting up on Any Machine with Nix](docs/nix_setup.md)

---

## 🎶 Setting up MUSIC

[How to set up MUSIC](docs/music_setup.md)

## 🚀 Setting up GIZMO

[How to set up GIZMO](docs/gizmo_setup.md)

## 🌌 How to run GIZMO+MUSIC

[How to generate GIZMO ICs with MUSIC](docs/music_gizmo_ics.md)

## 🔡 Sample run parameters and how to use them

## 🛠️ FAQ

Ask questions in person or on GitHub Issues! Here's some general info:

- **Compilation Errors**: Check your `Makefile` for correct library paths.

---

## 📖 References

- [GIZMO Documentation](http://www.tapir.caltech.edu/~phopkins/Site/GIZMO_files/gizmo_documentation.html)
- [MUSIC Documentation](https://www-n.oca.eu/ohahn/MUSIC/)

---

💡 For questions or suggestions, feel free to contribute or open an issue in this repository!
