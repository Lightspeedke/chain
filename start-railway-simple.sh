#!/bin/bash

echo "🚂 XYBERCHAIN MAINNET - RAILWAY"
echo "==============================="

PORT=${PORT:-8545}
WS_PORT=$((PORT + 1))
DATADIR="./data"

echo "📡 Starting on port: $PORT"

# Ensure data directory exists
mkdir -p $DATADIR

# Initialize if needed
if [ ! -d "$DATADIR/geth" ]; then
    echo "📦 Initializing..."
    ./geth --datadir $DATADIR init genesis.json
fi

echo "🚀 Starting XYBERCHAIN (no mining)..."

# Start without mining first (more stable)
exec ./geth --datadir $DATADIR \
    --networkid 9194 \
    --http \
    --http.addr "0.0.0.0" \
    --http.port $PORT \
    --http.corsdomain "*" \
    --http.vhosts "*" \
    --http.api "eth,net,web3,personal,admin,miner,txpool,debug,clique" \
    --ws \
    --ws.addr "0.0.0.0" \
    --ws.port $WS_PORT \
    --ws.origins "*" \
    --ws.api "eth,net,web3,personal,admin,miner,txpool,clique" \
    --nodiscover \
    --maxpeers 0 \
    --verbosity 2 \
    --cache 128
