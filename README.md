# 🚀 Tutorial: Running GIZMO with MUSIC 🛠️

This tutorial provides a step-by-step guide to setting up and running cosmological simulations using **GIZMO** (a versatile astrophysical simulation code) with **MUSIC** (Multiscale Initial Conditions Generator).

Please ⭐ if this was useful!

---

## 🗂️ Table of Contents
1. [Introduction](#introduction)
2. [Cluster Setup](#cluster-setup)
3. [MUSIC/GIZMO Setup](#code-setup)
4. [Sample Run Files](#sample-run-parameters-and-how-to-use-them)
5. [FAQ](#faq)
6. [References](#references)

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
- [Setting up on Trillium](docs/trillium_setup.md)
- [Setting up on Niagara](docs/niagara_setup.md)
- [Setting up on CITA Cluster](docs/cita_setup.md)
- [Setting up on CITA Starq Cluster](docs/starq_setup.md)
- [Setting up on Any Machine with Nix](docs/nix_setup.md)

## 💻 **Code Setup**

[🎶 How to set up MUSIC](docs/music_setup.md)

[🚀 How to set up GIZMO](docs/gizmo_setup.md)

[🌌 How to generate GIZMO ICs with MUSIC](docs/music_gizmo_ics.md)

## 🔡 Template files

MUSIC config files:
* `music_dm_only.conf` - config file for DM-only ICs 
* `music_b+dm.conf` - config file for DM+baryons ICs 

GIZMO Makefile system files:
* `NixMakefile.txt`
* `CITA-starqMakefile.txt`

GIZMO parameter files:
* `Config.sh`
* `gizmo_dm.params` - parameter file for DM-only MUSIC-generated ICs run
* `gizmo_b+dm.params` - parameter file for DM+baryons MUSIC-generated ICs run
 
GIZMO job submisson files:
* `Grun_starq.sh`
* `Grun_CITA.sh`
* `Grun_Niagara.sh`

MUSIC job submisson files:
* `Mrun_starq.sh`
* `Mrun_CITA.sh`
* `Mrun_Niagara.sh`

## 🛠️ FAQ

Ask questions in person or on GitHub Issues! Here's some general info:

- **Compilation Errors**: Check your `Makefile` for correct library paths.

---

## 📖 References

- [GIZMO Documentation](http://www.tapir.caltech.edu/~phopkins/Site/GIZMO_files/gizmo_documentation.html)
- [MUSIC Documentation](https://www-n.oca.eu/ohahn/MUSIC/)

---

💡 For questions or suggestions, feel free to contribute or open an issue in this repository!
