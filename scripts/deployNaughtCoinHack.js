const hre = require("hardhat");

async function main() {
  const naughtCoinHack = await hre.ethers.deployContract("NaughtCoinHack");
  await naughtCoinHack.waitForDeployment();
  console.log(`Deployed NaughtCoinHack.sol at address: ${naughtCoinHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });