# neut-quickstart

Dockerfile and helper scripts for building the neut-quickstart container.

Run the `halp` command to see what you can do with the container, e.g.

```bash
$ docker_run picker24/neut580_quickstart:alma9 halp


                                                                  Halp

Installed Software

   All non-system software is installed to /opt.

   The majority of the software is available in the environment from the start.

   See, e.g.
    $ which neutroot2

   Check the full environment with:
    $ printenv

   Sub-halp commands exist for software-specific help, try:
    $ halp neut
    $ halp neutroot2
    $ halp neutvect-converter
    $ halp neut-quickstart
    $ halp docker_run
```

Run `neut-quickstart --help` within the container to see the option for a high-level generator CLI:

```bash
$ neut-quickstart --help
  Required options:
  -o|--output <filename.hepmc3>  : Output HepMC3 file
  -n|--nevents <numevents>          : Specify the number of events to process or generate.

  Options:
  --neut-card <neut.card>        : NEUT card to specialize
  --neut-param <pname> <val>     : Specify arbitrary NEUT parameters.
                                   This will override parameters in the base card or set elsewhere 
                                   in this script.
                                   This can be used more than once.
  -t|--target <C|O|CH|H2O|Fe>       : Specify the target nucleus/molecule.
  -s|--species <nu[mu,e][,b]>       : Specify the neutrino species.
  -f|--flux <file.root><,histname>  : Throw an event rate according to flux * cross section. 
                                   Flux histogram should be binned in GeV.
  --uniform <from> <to>          : Throw a uniform event rate as a function of energy in MeV.
  --mono-E <E>                   : Throw a events with energy E in MeV.

  --verbose                      : Let NEUT say its thing
  --force                        : Continue even if output file already exists
  --debug                        : Copy NEUT card file and intermediate neutvect.root file, if it
                                   iexists, back to the output directory.

  --help                         : Print this message
```

To throw 100 nue events on a water target with a 5 GeV mono-energetic beam, you might run:

```bash
$ neut-quickstart -n 100 -t H2O --mono-E 5000 -o H2O.tiny.5GeV.hepmc3
```

This might output the example file, here: [H2O.tiny.5GeV.hepmc3](H2O.tiny.5GeV.hepmc3).

If you are running a significant number of events, you can compress the output file by specifying 
something like: `-o H2O.tiny.5GeV.hepmc3.gz` instead.

## docker_run

The `docker_run` shell function can be useful for QOL improvements on `docker run`. It automatically
attaches std in/out to a nw ephemeral container, mounts the host user home directory and sets 
the working directory to `$(pwd)` on the host if it is a subdirectory of the host user home directory.

For example, if you run the following from the directory `${HOME}/work/neut/myrun`

```bash
$ docker_run picker24/neut580_quickstart:alma9 neut-quickstart -n 100 -t H2O -o H2O.tiny.hepmc3
```

it will be expanded to

```bash
$ docker run -it --rm --volume ${HOME}:/root -w /root/work/neut/myrun picker24/neut580_quickstart:alma9 neut-quickstart -n 100 -t H2O -o H2O.tiny.hepmc3
```