Contains the Dockerfiles for building our build images (the images for the containers that we use to build for example Kafka applications in).

See Taskfile.yml for options.

## Static building

Build with `-tags=musl` (was `-tags=static_all` before alpine 3.11). Example of building a Go app inside a container, taken from order-service:

```
docker run \
    -v "$(pwd):/go/src/{{.PROJECT_DIR_FROM_GOPATH}}" \
    -w "/go/src/{{.PROJECT_DIR_FROM_GOPATH}}" \
    unitedwardrobe/golang-librdkafka:alpine3.11-golang1.14.2-librdkafka1.4.2-static \
    go build \
        -mod vendor \
        -tags musl \
        -o bin/{{.APP_NAME}} \
        -a /go/src/{{.PROJECT_DIR_FROM_GOPATH}}/cmd/{{.APP_NAME}}
```