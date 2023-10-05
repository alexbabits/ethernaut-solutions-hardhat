const hre = require("hardhat");

async function main() {
  const INITIAL_ETHER = hre.ethers.parseEther("0.003");
  const gatekeeperThreeHack = await hre.ethers.deployContract("GatekeeperThreeHack", {value: INITIAL_ETHER});
  await gatekeeperThreeHack.waitForDeployment();
  console.log(`Deployed GatekeeperThreeHack.sol at address: ${gatekeeperThreeHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });