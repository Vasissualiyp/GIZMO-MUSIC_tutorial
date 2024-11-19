Return to the [Main README](../README.md)

# Setting up MUSIC

Once you loaded all the necessary modules on your machine, here are the 
steps that you have to undergo if you want to run MUSIC:
1. [Git clone relevant MUSIC repo](#git-clone-music-repo)
2. [Compile the code, and make sure that the binary was created](#compile-music)
3. [Setup the run parameters](#setup-run-parameters)
4. [Create a submission script](#create-submission-script)
10. [Submit the job to your cluster (if working on a cluster) or run the executable (if running directly on the node)](#submit-the-job)
6. Track your job to see if there are any errors appearing.

## Git clone MUSIC repo

There is a public MUSIC repo, avaliable to everyone, on BitBucket.
You can clone in with:
```
git clone git@bitbucket.org:ohahn/music.git music
```

There is also my private MUSIC repo with better argument parsing,
PeakPatch integration, and other quality-of-life improvements.
If you want to get access to it, please let me know.

## Compile MUSIC

Navigate to the newly-cloned MUSIC source directory.
You can compile your code with `make`. It is recommended to 
compile it in parallel with:

```
make -j20
```

Where 20 is the number of jobs running in parallel, can change
it to something else reasonable.

After you're done with compilation, check that you have a 
binary with `ls MUSIC`. If the command output nothing, 
compilation failed, and you should check the logs.

If you change compile flags for some reason, recompile the code with

```
make clean
make -j20
````

You also can pipe errors with `make -j20 2&> err.out` to proccess them easier.

## Setup run parameters

The run parameters file for MUSIC has a few of options,
check out [music docs](https://www-n.oca.eu/ohahn/MUSIC/) 
for those. It doesn't really matter where the parameter file is located,
you will be referencing it when you will be running MUSIC.

Sample `music_dm_only.conf`, `music_b+dm.conf` parameter files 
are provided in this tutorial repo, in the `templates` directory. 
The two parameter files are for Dark Matter-only and baryons+DM 
initial conditions, respectively.

## Create submission script

Now we have to submit our job/run it.
You run MUSIC by calling the executable and parameters file as an argument.
For instance, if you are in run directory, which is just the music source directory 
`music`, with compiled MUSIC code, you would be running MUSIC directly with:

```
./MUSIC /path/to/config/file
```

For instance, if you want to run with sample parameter file, and you git cloned
`music` into the directory of this tutorial, you can do it with:

```
./MUSIC ../templates/music_dm_only.conf
```

This should run MUSIC directly.

While running locally might work for smaller boxes, if you want to set up
a *real* simulation, you might find out quickly that there is not much memory.
So for Niagara, CITA and CITA-starq, you can submit the 
job to cluster using submission script. Just grab one of them for your 
machine from the `templates` directory, change the path to parameters file
and MUSIC executable (if needed), and you should be all set!

The submission scripts have filenames of format `music_run_machine.sh` and are 
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
