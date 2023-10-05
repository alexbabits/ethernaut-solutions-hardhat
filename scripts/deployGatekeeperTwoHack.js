const hre = require("hardhat");

async function main() {
  const gatekeeperTwoHack = await hre.ethers.deployContract("GatekeeperTwoHack", ["0xcA78014f57465131F1FB62421367e0b638131DE3"]);
  await gatekeeperTwoHack.waitForDeployment();
  console.log(`Deployed GatekeeperTwoHack.sol at address: ${gatekeeperTwoHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });