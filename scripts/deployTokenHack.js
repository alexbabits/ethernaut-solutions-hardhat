const hre = require("hardhat");

async function main() {
  const tokenHack = await hre.ethers.deployContract("TokenHack", ["0x34cD308b18b95A521069eD7AC9f0FD223393f763"]);
  await tokenHack.waitForDeployment();
  console.log(`Deployed TokenHack.sol at address: ${tokenHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });