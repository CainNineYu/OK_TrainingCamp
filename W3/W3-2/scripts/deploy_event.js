
const hre = require("hardhat");

async function main() {
  const eventLog = await hre.ethers.getContractFactory("eventLog");
  const test = await eventLog.deploy();
  await test.deployed();
  console.log("eventLog deployed to:", test.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
