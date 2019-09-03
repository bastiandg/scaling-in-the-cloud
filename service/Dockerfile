FROM golang:1.12 as builder

COPY hashy.go /go/src/hashy/
COPY go.mod /go/src/hashy/
COPY go.sum /go/src/hashy/
WORKDIR /go/src/hashy

RUN CGO_ENABLED=0 GO111MODULE=on go build -o /go/bin/hashy

FROM gcr.io/distroless/static
#FROM scratch
COPY --from=builder /go/bin/hashy /
ENTRYPOINT ["/hashy"]
