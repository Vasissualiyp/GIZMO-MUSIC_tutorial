Return to the [Main README](../README.md)

# Setting up GIZMO

Once you loaded all the necessary modules on your machine, here are the 
steps that you have to undergo if you want to run GIZMO:
1. [Git clone relevant GIZMO repo](#git clone gizmo repo)
2. Add your system compile flags to `Makefile` (only for starq or if the system is not in the gizmo repo yet)
3. Change `Makefile.systype` to your system name
4. Move `TREECOOL` to your runtime directory
5. Get the spcool tables
6. Setup the compilation flags in `Config.sh`
7. Compile the code, and make sure that the binary was created
8. Setup the run parameters
9. Create a submission script
10. Submit the job to your cluster (if working on a cluster) or run the executable (if running directly on the node)
11. Track your job to see if there are any errors appearing.

## Git clone GIZMO repo
