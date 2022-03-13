const { ethers, network } = require("hardhat");
// const delay = require('./delay');

const ERC20Addr = require(`../deployments/${network.name}/ERC20Token.json`)


async function main() {

    let [owner, second] = await ethers.getSigners();

    let ERC20Token = await ethers.getContractAt("ERC20Token",
        ERC20Addr.address,
        owner);

    await ERC20Token.transfer(second.address, 1000);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });


  // duration = 60;
  // await delay.advanceTime(ethers.provider, duration); 
  // await delay.advanceBlock(ethers.provider);