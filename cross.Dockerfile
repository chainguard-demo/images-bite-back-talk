# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/go:latest-dev@sha256:2f71c4d2c68eb401c9311611663d2d12a0632fb29895bbccf3c840d79a4d0f9f AS builder
ARG TARGETOS
ARG TARGETARCH
WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:1c785f2145250a80d2d71d2b026276f3358ef3543448500c72206d37ec4ece37
COPY --from=builder /work/hello /hello 

ENTRYPOINT ["/hello"]
