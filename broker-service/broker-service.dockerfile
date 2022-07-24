# base go image to build the executable
FROM golang:1.18-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerService ./cmd/api

RUN chmod +x /app/brokerService

# build a tiny broker image (only contains the executable)
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerService /app

CMD ["/app/brokerService"]