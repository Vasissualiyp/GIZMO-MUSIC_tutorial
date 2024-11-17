# 🚀 Tutorial: Running GIZMO with MUSIC 🛠️

This tutorial provides a step-by-step guide to setting up and running cosmological simulations using **GIZMO** (a versatile astrophysical simulation code) with **MUSIC** (Multiscale Initial Conditions Generator).

---

## 🗂️ Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
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

---

## 🖥 **Cluster Setup**
- [Setting up on Niagara](docs/niagara_setup.md): Step-by-step guide for SciNet’s Niagara supercomputer.
- [Setting up on CITA Cluster](docs/cita_setup.md): Instructions for deploying on CITA’s general-purpose cluster.
- [Setting up on CITA Starq Cluster](docs/starq_setup.md): Specific setup for the Starq cluster.
- [Setting up on Any Machine with Nix](docs/nix_setup.md): Universal setup guide for any NixOS-compatible machine.

---

## ⚙️ Installation

### Installing MUSIC

1. Clone the MUSIC repository:
   ```bash
   git clone https://github.com/hd4/MUSIC.git
   cd MUSIC
   ```

2. Build MUSIC:
   ```bash
   make
   ```

3. Verify installation:
   ```bash
   ./MUSIC --version
   ```

### Installing GIZMO

1. Clone the GIZMO repository:
   ```bash
   git clone https://bitbucket.org/phopkins/gizmo-public.git
   cd gizmo-public
   ```

2. Configure and build:
   - Edit the `Makefile` to suit your system configuration.
   - Compile the code:
     ```bash
     make
     ```

3. Verify installation by running a test problem:
   ```bash
   ./GIZMO test_galaxy.param
   ```

---

## 🌌 Generating Initial Conditions with MUSIC

1. Create a parameter file for MUSIC:
   ```bash
   cp example_param.ini my_simulation.ini
   ```
   Modify the file to set:
   - **Box size**
   - **Cosmological parameters**
   - **Grid resolution**

2. Run MUSIC to generate initial conditions:
   ```bash
   ./MUSIC my_simulation.ini
   ```

3. Output files (e.g., `ics.dat`) will be generated in the specified output directory.

---

## 🚀 Running GIZMO

1. Copy the initial conditions file (`ics.dat`) to the GIZMO directory:
   ```bash
   cp path_to_ics/ics.dat gizmo-public/
   ```

2. Create or modify a parameter file for GIZMO (e.g., `my_simulation.param`) to match your simulation setup:
   ```bash
   cp test_galaxy.param my_simulation.param
   ```

3. Run GIZMO:
   ```bash
   mpirun -np 4 ./GIZMO my_simulation.param
   ```

4. Monitor the progress by examining the output files (e.g., snapshots and logs).

---

## 🔍 Visualizing Results

To visualize the results, use tools such as:
- **[yt](https://yt-project.org/)**: 
   ```python
   import yt
   ds = yt.load("snapshot_000.hdf5")
   yt.SlicePlot(ds, "z", "density").show()
   ```
- **Visualization software** like `ParaView` or `VisIt`.

---

## 🛠️ Troubleshooting

- **Compilation Errors**: Check your `Makefile` for correct library paths.
- **MUSIC Runtime Errors**: Ensure cosmological parameters are valid.
- **GIZMO Crashes**: Check logs for clues, verify initial conditions.

---

## 📖 References

- [GIZMO Documentation](http://www.tapir.caltech.edu/~phopkins/Site/GIZMO_files/gizmo_documentation.html)
- [MUSIC Documentation](https://www-n.oca.eu/ohahn/MUSIC/)

---

💡 For questions or suggestions, feel free to contribute or open an issue in this repository!
