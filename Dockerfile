# syntax=docker/dockerfile:1@sha256:87999aa3d42bdc6bea60565083ee17e86d1f3339802f543c0d03998580f9cb89
FROM cgr.dev/chainguard/go:latest-dev@sha256:92a1e21dd60f7c565e1288aaa796f34d78967274dbcc157d62c9d636fe50d7fb AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:60582b2ae6074f641094af0f370d4ab241aab271858a66223dcde7eee9f51638
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
