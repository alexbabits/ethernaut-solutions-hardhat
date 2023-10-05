const hre = require("hardhat");

async function main() {
  const denialHack = await hre.ethers.deployContract("DenialHack", ["0x1B09135B82bC243286CDC635A60fF75e81A52b5d"]);
  await denialHack.waitForDeployment();
  console.log(`Deployed DenialHack.sol at address: ${denialHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });