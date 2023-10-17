
[![GitHub Actions Status](https://github.com/HEPData/hepdata-converter-docker/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/HEPData/hepdata-converter-docker/actions?query=branch%3Amain)
[![Docker Pulls](https://img.shields.io/docker/pulls/hepdata/hepdata-converter)](https://hub.docker.com/r/hepdata/hepdata-converter)

# hepdata-converter-docker

**Build system for creating Docker image used by GitHub Actions CI testing framework for hepdata-converter**

This is a *companion repository* for the
[hepdata-converter](https://github.com/HEPData/hepdata-converter)
repository (it is also included there as a submodule in the
`docker` directory).

This repository has only one purpose: to separate the `Dockerfile` from the
main [hepdata-converter](https://github.com/HEPData/hepdata-converter)
repository, in order to automate building Docker images with the help of
[GitHub Actions](https://github.com/HEPData/hepdata-converter-docker/actions) and
then pushing them to
[Docker Hub](https://hub.docker.com/r/hepdata/hepdata-converter).

The Docker image `hepdata-converter` contains the
[ROOT](https://root.cern.ch) and [YODA](https://yoda.hepforge.org/)
dependencies needed for running the
[hepdata-converter](https://github.com/HEPData/hepdata-converter) code,
but **not** the `hepdata-converter` package itself.

The basic workflow is as follows:

1. Modify `Dockerfile` (or any other files).
2. Commit it to the repository.
3. Push the code.
4. GitHub Actions will create a Docker image from the `Dockerfile` and upload
it to [Docker Hub](https://hub.docker.com/r/hepdata/hepdata-converter).

## For developers

**Warning:** any build on the main branch (or a tagged release) will
trigger upload of the new Docker image to Docker Hub, so be cautious
about it, especially if you plan to start breaking things.
