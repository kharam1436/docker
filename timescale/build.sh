#!/bin/bash

# Getting Docker Username
USERNAME=$1

# Getting the version
ORIGINAL_TIMESCALE_TAGS=$(wget -q https://registry.hub.docker.com/v1/repositories/timescale/timescaledb/tags -O -   \
| sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' \
| tr '}' '\n'  \
| awk -F: '{print $3}' \
| sort \
| grep '^2.*-pg11' )

MY_TIMESCALE_TAGS=$(wget -q https://registry.hub.docker.com/v1/repositories/kharam/timescale/tags -O -   \
| sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' \
| tr '}' '\n'  \
| awk -F: '{print $3}')

# Making the build list to build timescale image with more better docker support
build_list=()

# Making build list to build docker file
for TAG in $ORIGINAL_TIMESCALE_TAGS
do
  if [[ "$MY_TIMESCALE_TAGS" != *"$TAG"* ]]; then
    build_list+=( $TAG )
  fi
done

# Show the number of build items
echo "going to build ${#build_list[@]} number of docker images"

# Build all from the list
for i in ${!build_list[@]}
do
  TAG=${build_list[$i]}
  TARGET="${USERNAME}/timescale:${TAG}"
  docker build --build-arg TAG=${TAG} -t ${TARGET} -f ${PWD}/timescale/Dockerfile .
  docker push ${TARGET}
  docker rmi ${TARGET}
done

