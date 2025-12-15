# For testing versioning of images with private registry
FROM cgr.dev/chainguard.edu/go:1.25.3@sha256:047395c0c877b00242c8b034e767fcd735759a4f4c3e25e8813ab20d0183bfa6 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:d44809cee093b550944c1f666ff13301f92484bfdd2e53ecaac82b5b6f89647d
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
