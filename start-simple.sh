#!/bin/bash

echo "🚂 XYBERCHAIN MAINNET - RAILWAY"
echo "==============================="

PORT=${PORT:-8545}
WS_PORT=$((PORT + 1))
DATADIR="./data"

echo "📡 HTTP: $PORT | WebSocket: $WS_PORT"

mkdir -p $DATADIR

if [ ! -d "$DATADIR/geth" ]; then
    echo "📦 Initializing..."
    ./geth --datadir $DATADIR init genesis.json
fi

echo "🚀 Starting XYBERCHAIN (Transaction Ready)..."

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
    --cache 128 \
    --txpool.globalslots 4096 \
    --txpool.globalqueue 1024
