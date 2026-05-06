# === Build image ===
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

# Install system dependencies for PostgreSQL
RUN apt-get update && apt-get install -y \
        libpq-dev \
        gcc \
        python3-dev \
        && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN if [ -f requirements.txt ]; then \
        pip install --no-cache-dir -r requirements.txt; \
        fi

# === Final image ===
FROM python:3.12-slim

# Install system dependencies for PostgreSQL - psycopg2 requires libpq
RUN apt-get update && apt-get install -y \
        libpq5 \
        && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
WORKDIR /app
COPY . .

RUN useradd app
USER app
EXPOSE 8003

CMD ["python", "app.py"]
