const { Web3 } = require('web3');

const web3 = new Web3('https://xyberchain-rpc.xyz/');

async function testXyberchain() {
    console.log('🌐 XYBERCHAIN MAINNET TEST');
    console.log('==========================');
    
    try {
        // Test connection
        const chainId = await web3.eth.getChainId();
        console.log('🔗 Chain ID:', chainId);
        
        if (chainId !== 9194n) {
            console.log('❌ Wrong chain ID!');
            return;
        }
        
        // Check balance
        const balance = await web3.eth.getBalance('0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1');
        console.log('💰 Balance:', web3.utils.fromWei(balance, 'ether'), 'XYB');
        
        // Check if mining
        const mining = await web3.eth.isMining();
        console.log('⛏️  Mining:', mining);
        
        // Get gas price
        const gasPrice = await web3.eth.getGasPrice();
        console.log('⛽ Gas Price:', gasPrice.toString());
        
        // Test transaction
        console.log('\n🚀 Sending test transaction...');
        
        const tx = {
            from: '0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1',
            to: '0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0',
            value: web3.utils.toWei('1', 'ether'),
            gas: 21000,
            gasPrice: gasPrice
        };
        
        const receipt = await web3.eth.sendTransaction(tx);
        console.log('✅ Transaction successful!');
        console.log('📝 TX Hash:', receipt.transactionHash);
        console.log('⛽ Gas Used:', receipt.gasUsed);
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        
        if (error.message.includes('circuit breaker')) {
            console.log('\n🔧 Circuit breaker is still active. Checking mining status...');
        }
    }
}

testXyberchain();
