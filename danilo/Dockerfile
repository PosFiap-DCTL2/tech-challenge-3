# =========================
# Stage 1: Builder
# =========================
FROM python:3.11-slim AS builder

# Definir diretório de trabalho
WORKDIR /build

# Dependências de build (se necessário para libs nativas)
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar arquivos de dependências
COPY requirements.txt .

# Atualizar pip e instalar dependências em um diretório isolado
RUN pip install --upgrade pip setuptools wheel \
    && pip install --no-cache-dir --prefix=/install -r requirements.txt


# =========================
# Stage 2: Runtime
# =========================
FROM python:3.11-slim

# Criar usuário não-root
RUN groupadd -r dockeruser \
    && useradd -r -g dockeruser -d /home/dockeruser -m -s /usr/sbin/nologin dockeruser

# Diretório da aplicação
WORKDIR /app

# Copiar dependências já prontas do builder
COPY --from=builder /install /usr/local

# Copiar código da aplicação
COPY app.py .
COPY requirements.txt .

# Ajustar permissões
RUN chown -R dockeruser:dockeruser /app

# Trocar para usuário não privilegiado
USER dockeruser

# Expor porta
EXPOSE 8005

# Comando de inicialização
CMD ["gunicorn", "--bind", "0.0.0.0:8005", "app:app"]