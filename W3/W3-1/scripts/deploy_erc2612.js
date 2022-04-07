const hre = require("hardhat");
const { writeAddr } = require('./artifact_log.js');

async function main() {
  // await hre.run('compile');
    const ERC2612 = await hre.ethers.getContractFactory("ERC2612");
    const token = await ERC2612.deploy("0xAA44EED795317c5A190F190F3966E22f561B0b84");

    await token.deployed();
    console.log("ERC2612 deployed to:", token.address);
    await writeAddr(token.address, "ERC2612", network.name)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
