# syntax=docker/dockerfile:1@sha256:87999aa3d42bdc6bea60565083ee17e86d1f3339802f543c0d03998580f9cb89
FROM cgr.dev/chainguard/go:latest-dev@sha256:041a53344f009008fdd8ec3d2dba43cc19a83d2b856635f802b09c8e76552b23 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:399c8cb4858f05aaa33f43f02a2e75f28d40f016c0f86e5ba6075769e3303791
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
