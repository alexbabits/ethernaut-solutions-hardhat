const hre = require("hardhat");

async function main() {
  const reentranceHack = await hre.ethers.deployContract("ReentranceHack", ["0x6991cA1453ecC06E033206C8a78D244FCadD7Fbd"]);
  await reentranceHack.waitForDeployment();
  console.log(`Deployed ReentranceHack.sol at address: ${reentranceHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });