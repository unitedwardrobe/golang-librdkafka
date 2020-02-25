golang-librdkafka

## Alpine

Build and tag (from within the directory that contains the Dockerfile):
```
ALPVER=3.11 GOVER=1.13.5 KAFKAVER=1.3.0 \
TAG=alpine${ALPVER}-golang${GOVER}-librdkafka${KAFKAVER} && \
docker build -t unitedwardrobe/golang-librdkafka:${TAG} . && \
docker push unitedwardrobe/golang-librdkafka:${TAG}
```

## Alpine (static - includes librdkafka)

Build and tag (from within the directory that contains the Dockerfile): 
```
ALPVER=3.11 GOVER=1.13.5 KAFKAVER=1.3.0 \
TAG=alpine${ALPVER}-golang${GOVER}-librdkafka${KAFKAVER}-static && \
docker build -t unitedwardrobe/golang-librdkafka:${TAG} . && \
docker push unitedwardrobe/golang-librdkafka:${TAG}
```

## Circle

Build and tag (from within the directory that contains the Dockerfile):
```
GOVER=1.13.5 KAFKAVER=1.3.0 \
TAG=circle-golang${GOVER}-librdkafka${KAFKAVER} && \
docker build -t unitedwardrobe/golang-librdkafka:${TAG} . && \
docker push unitedwardrobe/golang-librdkafka:${TAG}
```