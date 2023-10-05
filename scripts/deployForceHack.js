const hre = require("hardhat");

async function main() {
  const INITIAL_ETHER = hre.ethers.parseEther("0.01");
  const forceHack = await hre.ethers.deployContract("ForceHack", ["0xCb6bA7ac0fdABFFABb6E95102ebBfBf63519B9B0"], {value: INITIAL_ETHER});
  await forceHack.waitForDeployment();
  console.log(`Deployed ForceHack.sol at address: ${forceHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });