# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6
FROM cgr.dev/chainguard/go:latest-dev@sha256:fa9ef129b35dacc10c80f063f927df0cbb6336d38ef2131fb925048a720346cf AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:a301031ffd4ed67f35ca7fa6cf3dad9937b5fa47d7493955a18d9b4ca5412d1a
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
