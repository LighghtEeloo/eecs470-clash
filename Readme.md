# Clash in Docker for EECS470

Clash is a shallow-embedded hardware description language in Haskell. This repo is a docker setup for consistent clash build.

## Build Instruction

Thanks to docker building a container can be easily reproduced.

To build a docker image,
```bash
docker build -t eecs470-clash .
```
You will only need to run it once on a computer for a stable clash build.

And later if:
1. you have a project called simple, and
2. the project is located at `pwd`, namely you're at the project root, and
3. you want to mount the project into the container's `/simple` dir,
then you can run a container called "simple" based on the image,
```bash
docker run -it --name simple -v `pwd`:/simple eecs470-clash
```
You can run it multiple times for different projects.

## About Personal Configurations

I'm using zsh, so I included a copy of my configuration files in the repo. You can delete or modify the `zsh` directory and change the `COPY` lines in `Dockerfile` to accommodate your needs.

## Credits

An infinite sequence of thanks to sanpo for companion and tutorials on the docker usage.
