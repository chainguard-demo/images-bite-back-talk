# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6
# Load cross-platform helper functions
FROM --platform=$BUILDPLATFORM tonistiigi/xx@sha256:c64defb9ed5a91eacb37f96ccc3d4cd72521c4bd18d5442905b95e2226b0e707 AS xx

FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/go:latest-dev@sha256:4a30f86129f24490987653962cc3e244fccd3f69ad8e8400a7356631fa04d7b8 AS builder
COPY --from=xx / /
RUN xx-apk add --no-cache zlib-dev
ARG TARGETOS
ARG TARGETARCH
WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

#RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 go build -o hello ./cmd/server
RUN CGO_ENABLED=0 xx-go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:7bdd9720cefba78e8133c4d03eaaf3f18a25d147d2c8803cc830061e46b6b474
COPY --from=builder /work/hello /hello 

ENTRYPOINT ["/hello"]
