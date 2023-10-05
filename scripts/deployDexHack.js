const hre = require("hardhat");

async function main() {
  const dexHack = await hre.ethers.deployContract("DexHack", ["0xFcb91b59db7261c399C2abfB622E3A9d3DA49080"]);
  await dexHack.waitForDeployment();
  console.log(`Deployed DexHack.sol at address: ${dexHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });