# syntax=docker/dockerfile:1.4

FROM golang:1.21-alpine AS builder

RUN apk update && apk add --no-cache git ca-certificates

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o /portfolio-go-htmx .

FROM alpine:3.20
RUN apk update && apk add --no-cache ca-certificates
WORKDIR /
COPY --from=builder /portfolio-go-htmx /portfolio-go-htmx

EXPOSE 8080
ENTRYPOINT ["/portfolio-go-htmx"]
