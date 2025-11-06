# Start from the official Golang base image
FROM golang:1.21-alpine

# Install ca-certificates for TLS verification
RUN apk add --no-cache ca-certificates

# Set working directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Update certificates and Download dependencies
RUN update-ca-certificates && go mod download

# Copy the rest of the source code
COPY . .

# Build the Go app
RUN go build -o main .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
