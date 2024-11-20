Return to the [Main README](../README.md)

So you set up MUSIC and GIZMO separately. 
Now, how to make them work together?

# Creating GIZMO ICs with MUSIC

If you want to run actual FIRE-like simulations, you need to set up 
zoom-in cosmological Initial Conditions (ICs).
Here is a step-by-step process of doing that:

1. [Create Dark Matter (DM)-only ICs with MUSIC](#dm-ics)
2. [Evolve these ICs to epoch of interest with GIZMO (i.e. up to z=0)](#evolving-dm-only-ics-with-gizmo)
3. [Inspect the resulting GIZMO snapshot, identify the region of interest, which you will be zooming in at](#finding-region-of-interest)
4. [Figure out the geometric parameters of the zoom-in region](g#eometric-parameters-of-zoom-in-region-at-low-z)
5. [Correspond particles at final snapshot to the particles in the ICs](#corresponding-particles)
6. [Identify the region of zoom-in in ICs](#geometric-parameters-of-zoom-in-region-at-high-z)
7. [Re-create MUSIC ICs with baryons and zoom-in region](#dm-with-baryons-ics)
8. [???](#next)
9. Profit!

## DM ICs

Use the template `music_dm_only.conf` and edit it how much you like.

Things to generally keep in mind for this setp:
* You DO NOT zoom in yet, so nothing related to zoom-in regions should be enabled, and `levelmin`=`levelmax`
* Make sure that you don't have baryons with `baryons = no` and `Omega_b = 0`
* For transfer function (TF), use the one that doesn't contain baryons. 
  I.e. when generating from scratch, I go with `transfer = bbks`.
  You can also use some CAMB-generated TF, but it's much more involved
* Make sure that you set the seed for your level (in template, it would be `seed[8]`).
  Otherwise, you won't be able to reproduce these ICs when you need to include baryons
* Set `zstart` to something big, but not too big. i.e. 70-200 is what people usually use.
  FIRE uses 199, I believe, I use 99.

And general points on how to make MUSIC output GIZMO-compatible:
* `format = gadget2`
* `gadget_coarsetype = 2`
* `gadget_usekpc = yes` - VERY IMPORTANT! 
  However, this option is now legacy, so it might be something different by the time you read this.
* Set your `filename` to the same output location as GIZMO ICs input

## Evolving DM-only ICs with GIZMO

After the ICs file was successfully created, evolve it with GIZMO up to the timeframe of interest.
Things to keep in mind for this setp:
* Make sure that you have `BOX_PERIODIC` compilation flag! 
  The cosmological ICs are generally supposed to be in periodic boxes, and MUSIC is not different 
* Make sure that your `boxlength` in MUSIC (in Mpc/h) is the same as `BoxSize` in GIZMO (kpc/h) 
  run parameters file, otherwise things might go wrong...
* Double-check that cosmology (Omega values, hubble parameter...) are the same
* Make sure that `InitCondFile` in GIZMO parameters points to the MUSIC-generated ICs file
* Make sure that `ICFormat` in GIZMO parameters has the appropriate ICs file type
  (1 for binary, 3 for hdf5)
* Make sure that `TimeBegin` in GIZMO parameters corresponds to scale factor of `zstart` of MUSIC.
  Scale factor from redshift is `a = 1/(1+z)`.
* Make sure that `TimeMax` in GIZMO parameters corresponds to scale factor of your timeframe of interest.
* Make sure that `ComovingIntegration` in GIZMO parameters is set to 1.
* Make sure to have GIZMO creating snapshot at the timeframe of your interest. 

## Finding region of interest

Once you have the snapshot of interest, you can inspect it to find any nice halos.
You can use halo finders like Rockstar or Amiga, or maybe some
*ophthalmic photoreceptive neural organs*, i.e. eyes, by plotting density fields.

## Geometric parameters of zoom-in region at low z

Once you have your halo of interest, know roughly its position and size,
find out how large the zoom-in region should be, to form it properly.
I believe FIRE uses regions of size of 3 Mpc.
You can either use a box region (simpler), or ellipsoidal region.
Either way, more info is in the 
[MUSIC Documentation](https://www-n.oca.eu/ohahn/MUSIC/)

## Corresponding particles

Once you have your region at low z, you can figure out which particles are in it.
Find IDs of all particles that you want included in your high-res region. 
Then, look at MUSIC-generated ICs, and find out where are the particles with the same IDs
(IDs don't evolve with time in this simulation, so every particle can be tracked by their IDs)

## Geometric parameters of zoom-in region at high z

Now figure out what would be the geometric parameters of a region, that would include all 
the particles that you found in previous step. Again, you can end up with
either box high-res region, or ellipsoidal high-res region.
Either way, more info is in the 
[MUSIC Documentation](https://www-n.oca.eu/ohahn/MUSIC/)

## DM with baryons ICs

Once you have your region parameters, put them into your original DM-only MUSIC config file.
Then, make sure that you take care of the following:
* Zoom-in regions should be enabled, and `levelmin`<`levelmax`
* Make sure that you DO have baryons with `baryons = yes` and `Omega_b = ` whatever is your cosmology.
* For transfer function (TF), use the one that DOES contain baryons. 
  I.e. when generating from scratch, I go with `transfer = eisenstein`.
  Same comment is applied to CAMB TFs as before.
* Make sure that you set the seed for EVERY refinement level (in template, it would be `seed[8]-seed[12]`).
  Otherwise, you won't be able to reproduce these ICs.

## Next?

Congratulations, you have your MUSIC-generated cosmological ICs! 
It wasn't that hard, and wasn't that much work, right? Right?..
