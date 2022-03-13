const { ethers, network } = require("hardhat");

async function main() {
  let [owner, second]  = await ethers.getSigners();

  let eventLog = await ethers.getContractAt("eventLog",
    "0x5FbDB2315678afecb367f032d93F642f64180aa3",
    owner);

  await eventLog.deposit(10);

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });