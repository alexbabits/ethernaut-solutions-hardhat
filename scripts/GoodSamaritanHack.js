const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/GoodSamaritanHack.sol/GoodSamaritanHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 
    
    const hackAddress = "0xeE261152ac9E0b1b5fcFa4777337B5E068FeD49b"
    const hackContract = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    const result = await hackContract.attack();
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });