
![Build Status](https://travis-ci.org/HEPData/hepdata-converter-docker.svg?branch=master)

# Hepdata-converter-docker

*Build system for creating docker image used by travis testing framework for hepdata-converter*

This is a *companion repository* for https://github.com/HEPData/hepdata-converter repository
(it is also included there as a submodule in ```docker``` directory)

This repository has only one purpose - to separate Dockerfile from the main hepdata-converter
repository, in order to automaticate building docker images with the help of travis and then
pushing them to docker hub.

The basic workflow is as follows:

1. Modify Dockerfile / requirements.txt (or any other files)
2. Commit it to the repository
3. Push the code
4. Travis will create docker image from Dockerfile and upload it to dockerhub

## For developers

This file contains file requirements.txt, it is here on purpose, it should not be duplicated
in hepdata-converter repository. Also Travis already has dockerhub credentials for
dockerhub in it's encrypted variables, if credentials are ever changed also update secure
variables in travis build otherwise the image will be created but not uploaded.

**Warning:** any build will trigger upload of the new image (regardless of the branch,
  so be cautious about it, especially if you plan to start breaking things)
