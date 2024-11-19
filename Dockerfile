# Use a lightweight Go image
FROM golang:1.20 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the code
COPY . .

# Build the Go application
RUN go build -o main .

# Use a minimal base image for running the application
FROM debian:buster-slim
WORKDIR /app

# Copy the binary from the builder
COPY --from=builder /app/main .

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["./main"]
