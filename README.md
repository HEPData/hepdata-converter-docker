
[![Build Status](https://travis-ci.org/HEPData/hepdata-converter-docker.svg?branch=master)](https://travis-ci.org/HEPData/hepdata-converter-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/hepdata/hepdata-converter)](https://hub.docker.com/r/hepdata/hepdata-converter)

# hepdata-converter-docker

**Build system for creating Docker image used by Travis CI testing framework for hepdata-converter**

This is a *companion repository* for the
[hepdata-converter](https://github.com/HEPData/hepdata-converter)
repository (it is also included there as a submodule in the
`docker` directory).

This repository has only one purpose: to separate the `Dockerfile` from the
main [hepdata-converter](https://github.com/HEPData/hepdata-converter)
repository, in order to automate building Docker images with the help of
[Travis CI](https://travis-ci.org/HEPData/hepdata-converter-docker) and
then pushing them to
[DockerHub](https://hub.docker.com/r/hepdata/hepdata-converter).

The Docker image `hepdata-converter` contains the
[ROOT](https://root.cern.ch) and [YODA](https://yoda.hepforge.org/)
dependencies needed for running the
[hepdata-converter](https://github.com/HEPData/hepdata-converter) code.

The basic workflow is as follows:

1. Modify `Dockerfile` / `requirements.txt` (or any other files).
2. Commit it to the repository.
3. Push the code.
4. Travis will create a Docker image from the `Dockerfile` and upload
it to [DockerHub](https://hub.docker.com/r/hepdata/hepdata-converter).

## For developers

This repository contains a file `requirements.txt`. It is here on
purpose and should not be duplicated in the
[hepdata-converter](https://github.com/HEPData/hepdata-converter)
repository. Also
[Travis CI](https://travis-ci.org/HEPData/hepdata-converter-docker)
already has DockerHub credentials in its encrypted variables. If
credentials are ever changed, update the secure variables in the Travis
CI build, otherwise the Docker image will be created but not uploaded.

**Warning:** any build on the master branch (or a tagged release) will
trigger upload of the new Docker image to DockerHub, so be cautious
about it, especially if you plan to start breaking things.
