const hre = require("hardhat");

async function main() {
  const INITIAL_ETHER = hre.ethers.parseEther("0.01");
  const kingHack = await hre.ethers.deployContract("KingHack", ["0x4b3e03E4a6e964C7c950397c2bAe6389bb787Ca0"], {value: INITIAL_ETHER});
  await kingHack.waitForDeployment();
  console.log(`Deployed KingHack.sol at address: ${kingHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });