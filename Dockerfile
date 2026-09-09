# syntax=docker/dockerfile:1@sha256:ecfaec9ed6d810b56388c508f4121597bfbba70d41a6dfeee4d8cad5f295fc32
FROM cgr.dev/chainguard/go:latest-dev@sha256:92a1e21dd60f7c565e1288aaa796f34d78967274dbcc157d62c9d636fe50d7fb AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:399c8cb4858f05aaa33f43f02a2e75f28d40f016c0f86e5ba6075769e3303791
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
