const hre = require("hardhat");

async function main() {
  const dexTwoHack = await hre.ethers.deployContract("DexTwoHack", ["0xC0862eBf16D777fdF0394A03cAB9BCeAEb548304"]);
  await dexTwoHack.waitForDeployment();
  console.log(`Deployed DexTwoHack.sol at address: ${dexTwoHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });