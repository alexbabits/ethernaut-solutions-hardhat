const hre = require("hardhat");

async function main() {
  const goodSamaritanHack = await hre.ethers.deployContract("GoodSamaritanHack", ["0xc8585a756D66dba373089b0eA3420F5eC45B34C4"]);
  await goodSamaritanHack.waitForDeployment();
  console.log(`Deployed GoodSamaritanHack.sol at address: ${goodSamaritanHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });