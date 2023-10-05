const hre = require("hardhat");

async function main() {
  const shopHack = await hre.ethers.deployContract("ShopHack", ["0xD973d231DE5d273D6ebAeFd47420BA4C3B033cC6"]);
  await shopHack.waitForDeployment();
  console.log(`Deployed ShopHack.sol at address: ${shopHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });