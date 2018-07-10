FROM golang:alpine as builder
WORKDIR /go/src/nomad-exporter
COPY . .
RUN apk --update --no-cache add git && \
        go get -d -v ./... && \
        go install -v ./...

FROM alpine:latest
WORKDIR /
COPY --from=builder /go/bin/nomad-exporter .
RUN apk --update --no-cache add ca-certificates

ENTRYPOINT ["/nomad-exporter"]
