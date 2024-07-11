FROM golang:1.22.5 AS builder
WORKDIR /src
COPY . .
RUN go mod download
RUN CGO_ENABLED=1 GOOS=linux go build -o ./build --tags "fts5" -a -ldflags '-linkmode external -extldflags "-static"' .


FROM alpine:latest AS app
RUN apk --no-cache add tzdata ca-certificates bash
ENV TZ="Asia/Kolkata"
COPY --from=builder /src/build .
CMD ["./build"]