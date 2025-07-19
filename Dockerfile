FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Download Geth
RUN wget -q https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.13.15-c5ba367e.tar.gz && \
    tar -xzf geth-linux-amd64-1.13.15-c5ba367e.tar.gz && \
    cp geth-linux-amd64-1.13.15-c5ba367e/geth ./geth && \
    chmod +x ./geth && \
    rm -rf geth-linux-amd64-1.13.15-c5ba367e*

# Copy files
COPY genesis.json ./
COPY start-railway.sh ./

# Create password file
RUN echo "xyberchain-railway-2024" > password.txt && \
    chmod +x ./start-railway.sh && \
    mkdir -p ./data

# Expose port
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-8545} || exit 1

# Start
CMD ["./start-railway.sh"]
