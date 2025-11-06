# Build stage
FROM golang:1.21-alpine AS builder

# Change apk mirror to aliyun and install ca-certificates only (git removed)
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --no-cache ca-certificates

# Set working directory
WORKDIR /app

# Copy go modules
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source
COPY . .

# Build the binary
RUN go build -o main .

# Final stage
FROM alpine:latest

# Install ca-certificates
RUN apk add --no-cache ca-certificates

# Set working directory
WORKDIR /root/

# Copy the binary from builder
COPY --from=builder /app/main .

# Expose port
EXPOSE 8080

# Run binary
CMD ["./main"]
