const hre = require("hardhat");

async function main() {
  const telephoneHack = await hre.ethers.deployContract("TelephoneHack", ["0xF38EDb9dE79D1aaA59611a786047d4493989079a"]);
  await telephoneHack.waitForDeployment();
  console.log(`Deployed TelephoneHack.sol at address: ${telephoneHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });