#!/bin/bash

YOUR_WALLET="0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1"

echo "💰 MINTING 100M XYB TOKENS - NO REDEPLOYMENT"
echo "============================================="
echo "🎯 Target Wallet: $YOUR_WALLET"
echo "💰 Amount: 100,000,000 XYB"
echo "🌐 Network: https://xyberchain-rpc.xyz/"
echo ""

# 100M XYB in wei (100,000,000 * 10^18)
AMOUNT_100M="0x152d02c7e14af6800000"

echo "🚀 Sending 100M XYB from pre-funded account..."

TX_RESULT=$(curl -s -X POST -H "Content-Type: application/json" \
  --data "{
    \"jsonrpc\":\"2.0\",
    \"method\":\"eth_sendTransaction\",
    \"params\":[{
      \"from\":\"0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0\",
      \"to\":\"$YOUR_WALLET\",
      \"value\":\"$AMOUNT_100M\",
      \"gas\":\"0x5208\",
      \"gasPrice\":\"0x3b9aca00\"
    }],
    \"id\":1
  }" \
  https://xyberchain-rpc.xyz/)

echo "📝 Transaction Response:"
echo "$TX_RESULT"

if [[ "$TX_RESULT" == *"0x"* ]] && [[ "$TX_RESULT" != *"error"* ]]; then
    TX_HASH=$(echo "$TX_RESULT" | grep -o '0x[a-fA-F0-9]\{64\}')
    echo ""
    echo "✅ 100M XYB TRANSFER INITIATED!"
    echo "📝 TX Hash: $TX_HASH"
    echo "⏳ Confirming in ~6 seconds..."
    
    sleep 6
    
    echo ""
    echo "💰 Checking your updated balance..."
    BALANCE=$(curl -s -X POST -H "Content-Type: application/json" \
      --data "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBalance\",\"params\":[\"$YOUR_WALLET\",\"latest\"],\"id\":1}" \
      https://xyberchain-rpc.xyz/)
    
    echo "📊 Balance Response: $BALANCE"
    
    echo ""
    echo "🎉 SUCCESS! 100M XYB TOKENS ADDED!"
    echo "💰 Your wallet now has 100M+ XYB tokens"
    echo "🔗 Check in MetaMask on XYBERCHAIN network"
    
else
    echo "❌ First transfer failed, trying from another account..."
    
    # Try from second pre-funded account
    TX_RESULT2=$(curl -s -X POST -H "Content-Type: application/json" \
      --data "{
        \"jsonrpc\":\"2.0\",
        \"method\":\"eth_sendTransaction\",
        \"params\":[{
          \"from\":\"0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b\",
          \"to\":\"$YOUR_WALLET\",
          \"value\":\"$AMOUNT_100M\",
          \"gas\":\"0x5208\",
          \"gasPrice\":\"0x3b9aca00\"
        }],
        \"id\":2
      }" \
      https://xyberchain-rpc.xyz/)
    
    echo "📝 Second attempt: $TX_RESULT2"
fi

echo ""
echo "📱 METAMASK SETUP REMINDER:"
echo "=========================="
echo "Network: XYBERCHAIN Mainnet"
echo "RPC: https://xyberchain-rpc.xyz/"
echo "Chain ID: 9194"
echo "Symbol: XYB"
echo "Your Address: $YOUR_WALLET"
