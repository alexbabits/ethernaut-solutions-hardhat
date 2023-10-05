const hre = require("hardhat");

async function main() {
  const magicNumberHack = await hre.ethers.deployContract("MagicNumberHack", ["0xC012e948634b58841383B0b10092B0335C5434b5"]);
  await magicNumberHack.waitForDeployment();
  console.log(`Deployed MagicNumberHack.sol at address: ${magicNumberHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });