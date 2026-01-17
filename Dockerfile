# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6
FROM cgr.dev/chainguard/go:latest-dev@sha256:db5fd22b714032b054bf3de5e9d4f4a6d0321adc0682e1d10edd8f6f53a41901 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:3348c5f7b97a4d63944034a8c6c43ad8bc69771b2564bed32ea3173bc96b4e04
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
