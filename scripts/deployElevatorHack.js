const hre = require("hardhat");

async function main() {
  const elevatorHack = await hre.ethers.deployContract("ElevatorHack", ["0x975a18Ff792b2603B88B47Ae597dc2Cbf6BD1F7f"]);
  await elevatorHack.waitForDeployment();
  console.log(`Deployed ElevatorHack.sol at address: ${elevatorHack.target}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });