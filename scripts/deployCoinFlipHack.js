const hre = require("hardhat");

async function main() {
  const coinFlipHack = await hre.ethers.deployContract("CoinFlipHack", ["0xd8555aE8F4CFD6574F1c38742A272BA515c1cC27"]);
  await coinFlipHack.waitForDeployment();
  console.log(`Deployed CoinFlipHack.sol at address: ${coinFlipHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });