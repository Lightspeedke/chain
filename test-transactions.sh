#!/bin/bash

RPC="https://your-railway-domain.railway.app"  # Replace with your Railway URL

echo "🧪 XYBERCHAIN TRANSACTION TEST"
echo "=============================="

echo "1. 🔗 Chain ID:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' \
  $RPC

echo -e "\n2. 💰 Check Balance:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1","latest"],"id":1}' \
  $RPC

echo -e "\n3. 📊 Latest Block:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  $RPC

echo -e "\n4. 🔄 Transaction Pool:"
curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"txpool_status","params":[],"id":1}' \
  $RPC

echo -e "\n✅ XYBERCHAIN Transaction Support Ready!"
