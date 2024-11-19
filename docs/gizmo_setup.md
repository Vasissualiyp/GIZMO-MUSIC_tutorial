Return to the [Main README](../README.md)

Before you set up GIZMO, navigate to directory you want to run sims in.
For the rest of this, I will assume that you are already there.

# Setting up GIZMO

Once you loaded all the necessary modules on your machine, here are the 
steps that you have to undergo if you want to run GIZMO:
1. [Git clone relevant GIZMO repo](#git-clone-gizmo-repo)
2. [Add your system compile flags to `Makefile` (only for starq/nix or if the system is not in the gizmo repo yet)](#makefile-edits)
3. [Change `Makefile.systype` to your system name](#makefile.systype)
4. [Move `TREECOOL` to your runtime directory](#move-treecool)
5. [Setup the compilation flags in `Config.sh`](#set-compilation-flags)
6. [Get the spcool tables](#get-spcool-tables)
7. [Compile the code, and make sure that the binary was created](#compile-gizmo)
8. [Setup the run parameters](#setup-run-parameters)
9. [Create a submission script](#create-submission-script)
10. [Submit the job to your cluster (if working on a cluster) or run the executable (if running directly on the node)](#submit-the-job)
11. Track your job to see if there are any errors appearing.

## Git clone GIZMO repo

If you don't have access to any private gizmo repositories, talk to Norm to ask Phil Hopkins/Mike Grudić to 
add you to the repository, if you can.

If you don't have access, you can clone the public GIZMO repo with:
```
git clone git@bitbucket.org:phopkins/gizmo-public.git gizmo
```

Private GIZMO repo can be cloned with:
```
git clone git@bitbucket.org:phopkins/gizmo.git gizmo
```

Private GIZMO+STARFORGE repo can be cloned with:
```
git clone git@bitbucket.org:guszejnov/gizmo_imf.git gizmo
```

After you git cloned successfully, navigate to the new directory:
```
cd gizmo
```
This is GIZMO source code. Here of current interest we have 3 files:
`Makefile`, `Makefile.systype`, and `Config.sh`.

## Makefile edits
**This only applies if you are running on starq on nix! 
Skip this step for Niagara and non-starq CITA machines**

Find the Makefile edits for your system in `templates` directory of this tutorial.
Copy its contents into clipboard.
Then, in gizmo Makefile, find first occurence of 'CITA' string.
Paste the contents of clipboard right above it, so it looks like:
```
ifeq ($(SYSTYPE), "your_system")
...
endif
ifeq ($(SYSTYPE), "CITA")
```

For starq, this is it.

For Nix, you also have to change the line `PERL = /usr/bin/perl` to
`PERL = $(PERL_PATH)/bin/perl` in the beginning of Makefile.

## Makefile.systype
In another file, `Makefile.systype`, uncomment your system and comment out  
any other systems (by default it is Frontera).

If your machine isn't there, comment everything out and append your system
just like any other. The variables for our machines are 
* `SciNet` for Niagara
* `CITA` for non-starq CITA machines
* `CITA-starq` for starq
* `Nix` for nix

## Move TREECOOL
Now you have to move `TREECOOL` to your runtime directory.
While in `gizmo` source directory, run this command:
```
cp ./cooling/TREECOOL <your_runtime_dir>/TREECOOL
```

Assuming that your runtime directory is just parent directory of gizmo
(how I usually do it), it's just:

```
cp ./cooling/TREECOOL ../TREECOOL
```

## Set compilation flags
Now we need to set compilation flags - and there is a lot!
The ones that I set 100% of the time are:
```
HYDRO_MESHLESS_FINITE_MASS
USE_FFTW3
```

And maybe, if I'm feeling adventurous:
```
OPENMP=2
MULTIPLEDOMAINS=16
```
Check out [gizmo docs](http://www.tapir.caltech.edu/~phopkins/Site/GIZMO_files/gizmo_documentation.html) 
for a complete set of instructions on what flags do what.
Add all those to `Config.sh` file in gizmo source directory.

## Get spcool tables

The way that we usually add the cooling tables is the same way it is recommended
in GIZMO documentation. Namely, in runtime directory, run this set of commands
to download the tarball of tables, untar them, and move them to expected
directory:
```
wget http://www.tapir.caltech.edu/~phopkins/public/spcool_tables.tgz
mkdir -p spcool_tables
tar -xzvf spcool_tables.tgz -C spcool_tables
mv spcool_tables/spcool_tables/* ./spcool_tables/
rm -rf spcool_tables/spcool_tables
rm -f -r spcool_tables.tgz
```

## Compile GIZMO

After you have done all of that, in the source gizmo directory, 
you can compile your code with `make`. It is recommended to 
compile it in parallel with:

```
make -j20
```

Where 20 is the number of jobs running in parallel, can change
it to something else reasonable.

After you're done with compilation, check that you have a 
binary with `ls GIZMO`. If the command output nothing, 
compilation failed, and you should check the logs.

If you change compile flags for some reason, recompile the code with

```
make clean
make -j20
````

You also can pipe errors with `make -j20 2&> err.out` to proccess them easier.

## Setup run parameters

Just like contents of `Config.sh`, the run parameters file for GIZMO
has a lot of options,
check out [gizmo docs](http://www.tapir.caltech.edu/~phopkins/Site/GIZMO_files/gizmo_documentation.html) 
for those. It doesn't really matter where the parameter file is located,
you will be referencing it when you will be running GIZMO.

Sample `gizmo.params` is provided in this tutorial repo, in the 
`templates` directory. You have to run MUSIC to generate initial conditions
for GIZMO first, running GIZMO without MUSIC first would result in your run failing. 

## Create submission script

Now we have to submit our job/run it.
You run GIZMO by calling the executable and parameters file as an argument.
For instance, if you are in run directory, which contains subdirectory `gizmo` 
with compiled GIZMO code, you would be running GIZMO directly with:

```
./gizmo/GIZMO /path/to/parameters/file
```

For instance, if you want to run with sample parameter file, and you git cloned
`gizmo` into the directory of this tutorial, you can do it with:

```
./gizmo/GIZMO ./templates/gizmo.params
```

This should run GIZMO directly.

Most of hydro runs are very big however, and running them on a local machine
is not an option. So for Niagara, CITA and CITA-starq, you can submit the 
job to cluster using submission script. Just grab one of them for your 
machine from the `templates` directory, change the path to parameters file
and GIZMO executable (if needed), and you should be all set!

The submission scripts have filenames of format `run_machine.sh` and are 
designed to work with sample parameters out of the box.

## Submit the job

If you're running not on a cluster, there is nothing to do for you here.

If you have made a submission script for the cluster you want to submit to,
you submit it with:

```
sbatch <job_script>
```
for Niagara, and 
```
qsub <job_script>
```
for CITA/CITA-starq. 
Keep in mind that for CITA, all job submission scripts should be run or Ricky
node. You can acces it from any CITA machine via: 
```
ssh ricky
```

You can monitor your job status with:
```
sqc -u $USER
```
for Niagara, or
```
qstat -u $USER
```
for CITA (again, only from Ricky).

You can prepend the command with `watch -n1` to see how your status changes
every second (change 1 to another number for different timeframe)

From now on, just look into the log files and see if anything abnormal is happening!
