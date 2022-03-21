const { ethers, network } = require('hardhat');
const myTokenMarket = require(`../deployments/dev/${network.name}-MyTokenMarket.json`);

async function main() {
  const [deployer] = await ethers.getSigners();
  let tokenMarket = await ethers.getContractAt(myTokenMarket.contractName, myTokenMarket.address, deployer,myTokenMarket.spender);
  await tokenMarket.withdraw(ethers.utils.parseEther('1.2343678236982'));
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});
