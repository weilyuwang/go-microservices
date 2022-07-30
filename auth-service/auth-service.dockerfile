# base go image to build the executable
FROM golang:1.18-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o authService ./cmd/api

RUN chmod +x /app/authService

# build a tiny broker image (only contains the executable)
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/authService /app

CMD ["/app/authService"]