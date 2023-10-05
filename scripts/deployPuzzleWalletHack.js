const hre = require("hardhat");

async function main() {
  const INITIAL_ETHER = hre.ethers.parseEther("0.02");
  const puzzleWalletHack = await hre.ethers.deployContract("PuzzleWalletHack", ["0x254Cac43657Dd7C45d2221de6508143C76d86615"], {value: INITIAL_ETHER});
  await puzzleWalletHack.waitForDeployment();
  console.log(`Deployed PuzzleWalletHack.sol at address: ${puzzleWalletHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });