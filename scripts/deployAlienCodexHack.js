const hre = require("hardhat");

async function main() {
  const alienCodexHack = await hre.ethers.deployContract("AlienCodexHack", ["0x15487e8975D1f743A28fa6D8fB14308Ae94B0ec4"], {gasLimit: 500000});
  await alienCodexHack.waitForDeployment();
  console.log(`Deployed AlienCodexHack.sol at address: ${alienCodexHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });