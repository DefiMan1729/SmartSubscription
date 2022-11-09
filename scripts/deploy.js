// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const Subs = await hre.ethers.getContractFactory("ManageSubscription");
  // provide the address of the token to be used for payment
  const subs = await Subs.deploy('0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2');

  await subs.deployed();

  console.log(
    `deployed to ${subs.address}`
  );
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
