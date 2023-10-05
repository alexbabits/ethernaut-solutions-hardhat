const hre = require("hardhat");

async function main() {
  const recoveryHelper = await hre.ethers.deployContract("RecoveryHelper");
  await recoveryHelper.waitForDeployment();
  console.log(`Deployed RecoveryHelper.sol at address: ${recoveryHelper.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });