# Clash in Docker for EECS470

Clash is a shallow-embedded hardware description language in Haskell. This repo is a docker setup for consistent clash build.

## Build Image

Thanks to docker building a container can be easily reproduced.

To build a docker image,

```console
docker build -t eecs470-clash .
```
You will only need to run it once on a computer for a stable clash build.

## Run Container

And later if:

1. you have a project called simple, and
2. the project is located at `pwd`, namely you're at the project root, and
3. you want to mount the project into the container's `/root/simple` dir,

then you can run a container called "simple" based on the image,

```console
docker run -it --name simple -v `pwd`:/root/simple eecs470-clash
```
You can run it multiple times for different projects.

## Final Tips Before You Start Working

I've also prepared a `settings.json` file for `hls` if you're using vscode. You may like to install the `Haskell` extension after copying the `.vscode` folder, located under `/root`, into your project.

## About Personal Configurations

I'm using zsh, so I included a copy of my configuration files in the repo. You can delete or modify the `zsh` directory and change the `COPY` lines in `Dockerfile` to accommodate your needs. You may also delete the rust lines which installs `exa`, a rust alternative for `ls`.

## Credits

An infinite sequence of thanks to sanpo for companion and tutorials on the docker usage.
