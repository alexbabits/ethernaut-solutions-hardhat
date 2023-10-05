const hre = require("hardhat");
const fortaABI = require("../artifacts/contracts/DoubleEntryPointBot.sol/IForta.json").abi;

// forta address: 0xF4fa9016B7a4126E47E1F1Af8eCAD2952f406F3b
// bot address: 0x22ccA82Ac9BddBAaaAeE80c728b98D5AE19AaE33

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Setting Bot using MetaMask account:", deployer.address); 

    const fortaAddress = "0xF4fa9016B7a4126E47E1F1Af8eCAD2952f406F3b"
    const fortaContract = new hre.ethers.Contract(fortaAddress, fortaABI, deployer);

    const result = await fortaContract.setDetectionBot("0x22ccA82Ac9BddBAaaAeE80c728b98D5AE19AaE33");
    await result.wait();
    console.log("Bot set, transaction hash:", result.hash);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});