#!/bin/bash

echo "🦊 METAMASK XYBERCHAIN CONNECTION FIX"
echo "===================================="

# Test if blockchain is responding
echo "1. Testing blockchain connection..."
RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' \
  http://localhost:8545)

if echo "$RESPONSE" | grep -q "0x23ea"; then
    echo "✅ Blockchain responding correctly"
    echo "   Response: $RESPONSE"
else
    echo "❌ Blockchain not responding correctly"
    echo "   Response: $RESPONSE"
    echo "   Make sure XYBERCHAIN is running: ./manage-xyberchain.sh start"
    exit 1
fi

echo ""
echo "2. MetaMask Network Configuration:"
echo "=================================="
echo "Network Name: XYBERCHAIN"
echo "New RPC URL: http://localhost:8545"
echo "Chain ID: 9194"
echo "Currency Symbol: XYB"
echo "Block Explorer URL: (leave empty)"

echo ""
echo "3. Common MetaMask Issues & Solutions:"
echo "====================================="
echo "❌ 'RPC does not match chainID'"
echo "   ✅ Solution: Clear MetaMask cache"
echo "   ✅ Settings > Advanced > Reset Account"
echo "   ✅ Re-add the network"

echo ""
echo "❌ 'Network already exists'"
echo "   ✅ Solution: Delete existing XYBERCHAIN network first"

echo ""
echo "❌ 'Unable to connect'"
echo "   ✅ Solution: Make sure http://localhost:8545 is accessible"
echo "   ✅ Check firewall settings"

echo ""
echo "4. Alternative: Use Browser Console Method"
echo "=========================================="
echo "Open browser console (F12) and run:"
echo ""
echo "ethereum.request({"
echo "  method: 'wallet_addEthereumChain',"
echo "  params: [{"
echo "    chainId: '0x23EA',"
echo "    chainName: 'XYBERCHAIN',"
echo "    nativeCurrency: {"
echo "      name: 'XYB',"
echo "      symbol: 'XYB',"
echo "      decimals: 18"
echo "    },"
echo "    rpcUrls: ['http://localhost:8545']"
echo "  }]"
echo "});"

echo ""
echo "5. Test Connection After Setup:"
echo "==============================="
echo "After adding to MetaMask:"
echo "- Switch to XYBERCHAIN network"
echo "- Check if balance shows for: 0x6eF461F0cbBff97d3BdFd35076B28D5D30a6d513"
echo "- Try sending a small transaction"

echo ""
echo "6. Import Test Account (Optional):"
echo "=================================="
echo "Private Key: 4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d"
echo "Address: 0x6eF461F0cbBff97d3BdFd35076B28D5D30a6d513"
echo "⚠️  Only use for testing! This is a well-known test key."
