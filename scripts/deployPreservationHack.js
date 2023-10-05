const hre = require("hardhat");

async function main() {
  const preservationHack = await hre.ethers.deployContract("PreservationHack");
  await preservationHack.waitForDeployment();
  console.log(`Deployed PreservationHack.sol at address: ${preservationHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });