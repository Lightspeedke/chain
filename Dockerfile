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
COPY start.sh ./

# Create password file and setup
RUN echo "xyberchain-railway-2024" > password.txt && \
    chmod +x ./start.sh && \
    mkdir -p ./data

# Expose port
EXPOSE $PORT

# Start XYBERCHAIN
CMD ["./start.sh"]
