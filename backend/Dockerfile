FROM golang:1.22.5 AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=1 GOOS=linux go build -o ./build --tags "fts5" -a -ldflags '-linkmode external -extldflags "-static"' .


FROM alpine:latest AS app
ENV TZ="Asia/Kolkata"
COPY --from=builder /src/build .
CMD ["./build"]