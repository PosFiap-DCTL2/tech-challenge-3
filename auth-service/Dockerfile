# ---------- Stage 1: Build ----------
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Dependências
COPY go.mod go.sum ./
RUN go mod download

# Código-fonte
COPY . .

# Build binário estático
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o auth-service

# ---------- Stage 2: Runtime ----------
FROM alpine:3.19

WORKDIR /app

# Certificados SSL (Postgres / HTTPS)
RUN apk --no-cache add ca-certificates

# Copia o binário
COPY --from=builder /app/auth-service .

# Porta padrão do serviço
EXPOSE 8001

# Executa o binário
ENTRYPOINT ["./auth-service"]
