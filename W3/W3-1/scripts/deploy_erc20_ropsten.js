const hre = require("hardhat");
const { writeAddr } = require('./artifact_log.js');

async function main() {
  // await hre.run('compile');
  const [deployer] = await ethers.getSigners();
  console.log("Deployer Balance:", (await deployer.getBalance()).toString());

  const ERC20Token = await hre.ethers.getContractFactory("ERC20Token");
  const token = await ERC20Token.deploy();

  await token.deployed();
  console.log("ERC20Token deployed to:", token.address);
  await writeAddr(token.address, "ERC20Token", network.name);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
