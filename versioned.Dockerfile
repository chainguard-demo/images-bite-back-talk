# For testing versioning of images with private registry
FROM cgr.dev/chainguard.edu/go:v1.25.5@sha256:08cb10ef823daefaa7cfb4c73a33309c5ea924c6b4aabef758c50a1f67c43668 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:99a5f826e71115aef9f63368120a6aa518323e052297718e9bf084fb84def93c
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
