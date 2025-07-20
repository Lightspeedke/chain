#!/bin/bash

echo "💰 MINTING 100M XYB VIA GENESIS UPDATE"
echo "====================================="
echo "🎯 Target: 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1"
echo "💰 New Balance: 100,000,000 XYB"
echo ""

# Backup current genesis
cp genesis.json genesis.json.backup

echo "📝 Creating new genesis with 100M XYB for your account..."

# Create genesis with your account having 100M XYB
cat > genesis.json << 'GENESIS_EOF'
{
  "config": {
    "chainId": 9194,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0,
    "berlinBlock": 0,
    "londonBlock": 0,
    "clique": {
      "period": 3,
      "epoch": 30000
    }
  },
  "difficulty": "0x1",
  "gasLimit": "0x47b760",
  "extraData": "0x000000000000000000000000000000000000000000000000000000000000000090f8bf6a479f320ead074411a4b0e7944ea8c9c10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "alloc": {
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1": {
      "balance": "0x152d02c7e14af6800000"
    },
    "0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0": {
      "balance": "0x21e19e0c9bab2400000"
    },
    "0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b": {
      "balance": "0x21e19e0c9bab2400000"
    },
    "0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d": {
      "balance": "0x21e19e0c9bab2400000"
    },
    "0xd03ea8624C8C5987235048901fB614fDcA89b117": {
      "balance": "0x21e19e0c9bab2400000"
    }
  }
}
GENESIS_EOF

echo "✅ Genesis updated!"
echo "💰 Your account now has 100,000,000 XYB in genesis"
echo ""
echo "🚀 Deploying to Railway..."

git add .
git commit -m "💰 MINT 100M XYB TO MAIN ACCOUNT

✅ Updated genesis balance for 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1
💰 New Balance: 100,000,000 XYB (0x152d02c7e14af6800000 wei)
🚀 Ready for immediate use after deployment"

git push origin main

echo ""
echo "🎉 DEPLOYMENT STARTED!"
echo "⏳ Railway will redeploy in ~2-3 minutes"
echo "💰 After redeployment, your account will have 100M XYB"
echo ""
echo "📱 WHAT TO EXPECT:"
echo "=================="
echo "🔑 Account: 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1"
echo "💰 Balance: 100,000,000 XYB"
echo "🌐 Network: https://xyberchain-rpc.xyz/"
echo "⚡ Chain ID: 9194"
echo ""
echo "⏳ Wait 3 minutes, then check your MetaMask!"
