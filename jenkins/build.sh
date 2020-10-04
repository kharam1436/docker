# Getting the version
ORIGINAL_JENKINS_TAGS=$(wget -q https://registry.hub.docker.com/v1/repositories/jenkins/jenkins/tags -O -   \
| sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' \
| tr '}' '\n'  \
| awk -F: '{print $3}' \
| sort \
| grep -v 'alpin\|centos')

MY_JENKINS_TAGS=$(wget -q https://registry.hub.docker.com/v1/repositories/kharam/jenkins/tags -O -   \
| sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' \
| tr '}' '\n'  \
| awk -F: '{print $3}')

# Making the build list to build jenkins image with more better docker support
build_list=()

# Making build list to build docker file
for TAG in $ORIGINAL_JENKINS_TAGS
do
  if [[ "$MY_JENKINS_TAGS" != *"$TAG"* ]]; then
    build_list+=( $TAG )
  fi
done

# including lts and latest, slim
build_list+=( "lts" "lts-jdk11" "lts-slim" "slim" "latest" )

# 
echo "going to build ${#build_list[@]} number of docker images"

# for i in ${!build_list[@]}
# do
#   TAG=${build_list[$i]}
#   TARGET="jenkins:${TAG}"

#   docker build --build-arg TAG=${TAG} -t ${TARGET} -f Dockerfile .
# done

TAG=lts
TARGET="jenkins:${TAG}"
docker build --build-arg TAG=${TAG} -t ${TARGET} -f Dockerfile .

echo "list all images in docker"
docker images
