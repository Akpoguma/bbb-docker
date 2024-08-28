
#!/usr/bin/env arch -x86_64 /bin/bash
version="$1"
[[ ! "$version" ]] && {
    echo "Need to enter version"
    Error
}
DOCKER_BUILDKIT=1 docker buildx build --platform linux/amd64 --load -f Dockerfile-modified -t destinyakpo/bbb-docker_bbb-web:$1 .
docker push destinyakpo/bbb-docker_bbb-web:$1