# Build API Server
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Install necessary dependencies
RUN apk add --no-cache git

# Download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server ./cmd/server

# Final lightweight image
FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata

WORKDIR /app

# Copy the built executable
COPY --from=builder /app/server .

# Expose port (adjust if your Go app uses a different port, but usually 8080 by default)
EXPOSE 8080

# Run the executable
CMD ["./server"]
