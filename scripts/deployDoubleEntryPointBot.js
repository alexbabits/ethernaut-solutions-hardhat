const hre = require("hardhat");

async function main() {
  const doubleEntryPointBot = await hre.ethers.deployContract("DoubleEntryPointBot", ["0xDb0be5b906a90c2fb6f21C94022fE840225a5F5b"]);
  await doubleEntryPointBot.waitForDeployment();
  console.log(`Deployed DoubleEntryPointBot.sol at address: ${doubleEntryPointBot.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });