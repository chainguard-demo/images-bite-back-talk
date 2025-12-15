# For testing versioning of images with private registry
FROM cgr.dev/chainguard.edu/go:v1.25.5@sha256:f8273aa92db42cb04e0f8920186c7df379198ca222d2b60ac23bf77d90166016 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:a301031ffd4ed67f35ca7fa6cf3dad9937b5fa47d7493955a18d9b4ca5412d1a
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
