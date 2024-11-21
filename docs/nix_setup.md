Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on any maching using Nix Flakes

*Current status: MUSIC works with Nix flake (talk to me to get acces to it),
and so far I almost got GIZMO to work, but didn't finish writing the flake
(there was no need).
Please, let me know if you DO have the need in running GIZMO locally!*

### Nix Flakes?
I wrote a [nix](https://nixos.org/) [flake](https://nixos.wiki/wiki/Flakes) 
to be able to use GIZMO/MUSIC locally on any nix-enabled machine.
The flake is in another repository.

Running through nix flake is recommended for personal use,
including on Linux, MacOS, or Windows via WSL.

The Nix flake is for use with NixOS or nix package manager. 
Nix package manager is available on Linux,
MacOS, or (if you are into this kind of stuff) Windows.
                                                         
### Purpose
With nix, you don't have to worry about dependencies, libraries, activation scripts, etc. If it works 
on one machine, it works on all of them (as long as they have nix packages)
                                                         
### Usage
To enter the environment, defined in this flake, after you git cloned this repository and enabled
flakes (as of November 2024, they are experimental), just run:
```
nix develop
```
All the packages will be downloaded and you will automatically enter the GIZMO+MUSIC Nix environment. 

After you did this, the only thing to do would be to add instructions to `Makefile` 
if you're using GIZMO, and set `SYSTYPE` in `Makefile.systype` to `nix`.
You can get the instructions in `templates` directory of this tutorial, and follow the 
[GIZMO set-up guide](gizmo_setup.md) to see how to put it in.

### Troubleshooting
If the command fail, that is probably because you didn't enable flakes. In that case, run the command with
temporarily enabling them:
```
nix develop --experimental-features 'nix-command flakes'
```
