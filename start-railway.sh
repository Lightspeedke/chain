#!/bin/bash

echo "🚂 XYBERCHAIN MAINNET - RAILWAY"
echo "==============================="
echo "🌐 Official XYBERCHAIN Blockchain"
echo "⚡ Proof of Authority (Clique)"
echo "💎 Native Currency: XYB"
echo "🔗 Chain ID: 9194"
echo ""

# Railway environment
PORT=${PORT:-8545}
WS_PORT=$((PORT + 1))
DATADIR="./data"
NETWORK_ID=9194

echo "📡 HTTP Port: $PORT"
echo "🔌 WebSocket Port: $WS_PORT"

# Check if account exists, if not import it
if ! ./geth --datadir $DATADIR account list | grep -q "90f8bf6a479f320ead074411a4b0e7944ea8c9c1"; then
    echo "🔑 Importing account..."
    echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" > temp_key.txt
    ./geth --datadir $DATADIR account import --password password.txt temp_key.txt
    rm temp_key.txt
fi

echo "🚀 Starting XYBERCHAIN..."
echo "🏭 Mining Address: 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1"
echo "💰 Pre-funded Balance: 10,000 XYB"
echo "⛏️  Mining: Enabled"
echo "🔓 Account: Auto-unlocked"
echo ""

# Start XYBERCHAIN
exec ./geth --datadir $DATADIR \
    --networkid $NETWORK_ID \
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
    --mine \
    --miner.etherbase "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
    --unlock "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
    --password password.txt \
    --allow-insecure-unlock \
    --maxpeers 25 \
    --verbosity 3 \
    --cache 512 \
    --nodiscover
