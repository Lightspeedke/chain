#!/bin/bash

RPC="https://xyberchain-rpc.xyz/"

echo "🌐 XYBERCHAIN MAINNET - SIMPLE TEST"
echo "==================================="
echo ""

echo "1. 🔗 Chain ID Test:"
CHAIN_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' \
  $RPC)
echo "$CHAIN_RESULT"

if [[ "$CHAIN_RESULT" == *"0x23ea"* ]]; then
    echo "✅ Chain ID: 9194 (0x23ea) - CORRECT!"
else
    echo "❌ Chain ID issue"
fi

echo ""
echo "2. 📊 Latest Block:"
BLOCK_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  $RPC)
echo "$BLOCK_RESULT"

echo ""
echo "3. 💰 Account Balance:"
BALANCE_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1","latest"],"id":1}' \
  $RPC)
echo "$BALANCE_RESULT"

echo ""
echo "4. ⛏️ Mining Status:"
MINING_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_mining","params":[],"id":1}' \
  $RPC)
echo "$MINING_RESULT"

if [[ "$MINING_RESULT" == *"true"* ]]; then
    echo "✅ Mining: ENABLED"
else
    echo "❌ Mining: DISABLED (this might cause transaction issues)"
fi

echo ""
echo "5. 🚀 Transaction Test:"
TX_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{
    "jsonrpc":"2.0",
    "method":"eth_sendTransaction",
    "params":[{
      "from":"0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1",
      "to":"0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0",
      "value":"0xde0b6b3a7640000",
      "gas":"0x5208",
      "gasPrice":"0x3b9aca00"
    }],
    "id":1
  }' \
  $RPC)

echo "$TX_RESULT"

if [[ "$TX_RESULT" == *"0x"* ]] && [[ "$TX_RESULT" != *"error"* ]]; then
    echo "✅ TRANSACTION SUCCESSFUL!"
elif [[ "$TX_RESULT" == *"circuit breaker"* ]]; then
    echo "❌ CIRCUIT BREAKER ERROR - Mining might be disabled"
elif [[ "$TX_RESULT" == *"error"* ]]; then
    echo "❌ TRANSACTION ERROR"
else
    echo "❓ UNKNOWN RESPONSE"
fi

echo ""
echo "📱 METAMASK SETUP:"
echo "=================="
echo "Network Name: XYBERCHAIN Mainnet"
echo "RPC URL: https://xyberchain-rpc.xyz/"
echo "Chain ID: 9194"
echo "Currency Symbol: XYB"
echo ""
echo "🔑 Test Account:"
echo "Address: 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1"
echo "Private Key: 4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d"
