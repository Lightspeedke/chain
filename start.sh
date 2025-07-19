#!/bin/bash

echo "🚂 XYBERCHAIN MAINNET - RAILWAY"
echo "==============================="
echo "💰 Transaction Support: ENABLED"
echo ""

PORT=${PORT:-8545}
WS_PORT=$((PORT + 1))
DATADIR="./data"

mkdir -p $DATADIR

# Initialize genesis if needed
if [ ! -d "$DATADIR/geth" ]; then
    echo "📦 Initializing genesis..."
    ./geth --datadir $DATADIR init genesis.json
fi

# Import the pre-funded account for transactions
echo "🔑 Setting up transaction account..."
ACCOUNT_EXISTS=$(./geth --datadir $DATADIR account list 2>/dev/null | grep -i "90f8bf6a479f320ead074411a4b0e7944ea8c9c1" || echo "")

if [ -z "$ACCOUNT_EXISTS" ]; then
    echo "🔑 Importing pre-funded account..."
    echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" > temp_key.txt
    ./geth --datadir $DATADIR account import --password password.txt temp_key.txt 2>/dev/null || true
    rm -f temp_key.txt
    echo "✅ Account imported"
fi

echo "🚀 Starting XYBERCHAIN with FULL TRANSACTION SUPPORT..."
echo "💰 Pre-funded Account: 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1"
echo "⛏️  Mining: ENABLED for transaction processing"
echo ""

# Start with mining and account unlocked for transactions
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
    --mine \
    --miner.etherbase "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
    --unlock "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
    --password password.txt \
    --allow-insecure-unlock \
    --txpool.globalslots 8192 \
    --txpool.globalqueue 2048 \
    --txpool.accountslots 256 \
    --txpool.accountqueue 128 \
    --txpool.pricelimit 1 \
    --miner.gasprice 1000000000 \
    --nodiscover \
    --maxpeers 0 \
    --verbosity 3 \
    --cache 256 \
    --syncmode "full"
