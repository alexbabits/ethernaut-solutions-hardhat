const hre = require("hardhat");

async function main() {
  const gatekeeperOneHack = await hre.ethers.deployContract("GatekeeperOneHack");
  await gatekeeperOneHack.waitForDeployment();
  console.log(`Deployed GatekeeperOneHack.sol at address: ${gatekeeperOneHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });