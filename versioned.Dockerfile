# For testing versioning of images with private registry
FROM cgr.dev/chainguard.edu/go:v1.25.5@sha256:08cb10ef823daefaa7cfb4c73a33309c5ea924c6b4aabef758c50a1f67c43668 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:3348c5f7b97a4d63944034a8c6c43ad8bc69771b2564bed32ea3173bc96b4e04
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
