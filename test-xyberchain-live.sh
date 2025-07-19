#!/bin/bash

RPC="https://xyberchain-rpc.xyz/"

echo "🌐 XYBERCHAIN MAINNET - LIVE TEST"
echo "================================="
echo "🔗 RPC: $RPC"
echo ""

echo "1. 🔗 Chain ID (should be 9194):"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' \
  $RPC | jq -r '.result' | xargs printf "Chain ID: %d\n"

echo -e "\n2. 📊 Latest Block:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  $RPC | jq -r '.result' | xargs printf "Block: %d\n"

echo -e "\n3. 💰 Pre-funded Account Balance:"
BALANCE=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1","latest"],"id":1}' \
  $RPC | jq -r '.result')
echo "Balance: $BALANCE wei"

echo -e "\n4. ⛏️ Mining Status:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_mining","params":[],"id":1}' \
  $RPC | jq -r '.result' | xargs printf "Mining: %s\n"

echo -e "\n5. 🔄 Transaction Pool:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"txpool_status","params":[],"id":1}' \
  $RPC | jq

echo -e "\n6. 🚀 Test Transaction (1 XYB):"
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

echo "$TX_RESULT" | jq

if echo "$TX_RESULT" | jq -e '.result' > /dev/null; then
    echo "✅ Transaction successful!"
    TX_HASH=$(echo "$TX_RESULT" | jq -r '.result')
    echo "📝 TX Hash: $TX_HASH"
else
    echo "❌ Transaction failed!"
    echo "$TX_RESULT" | jq -r '.error.message'
fi

echo -e "\n📱 METAMASK CONFIGURATION:"
echo "=========================="
echo "Network Name: XYBERCHAIN Mainnet"
echo "RPC URL: https://xyberchain-rpc.xyz/"
echo "Chain ID: 9194"
echo "Currency Symbol: XYB"
echo "Block Explorer: N/A"
echo ""
echo "🔑 Test Account (has 10,000 XYB):"
echo "Address: 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1"
echo "Private Key: 4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d"
echo ""
echo "✅ XYBERCHAIN MAINNET IS LIVE!"
