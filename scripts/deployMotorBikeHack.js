const hre = require("hardhat");

async function main() {
  const motorBikeHack = await hre.ethers.deployContract("MotorBikeHack");
  await motorBikeHack.waitForDeployment();
  console.log(`Deployed MotorBikeHack.sol at address: ${motorBikeHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });