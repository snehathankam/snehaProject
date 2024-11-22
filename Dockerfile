# Use a lightweight Go image
FROM golang:1.21-alpine as builder

# Set the working directory inside the container
WORKDIR /build

# Copy src to destination
COPY . .
RUN go mod download


# Build the Go application
RUN go build -o ./userapi

# Use a minimal base image for running the application
FROM gcr.io/distroless/base-debian12

WORKDIR /app

# Copy the binary from the builder
COPY --from=builder /build/userapi ./userapi
# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["/app/userapi"]
