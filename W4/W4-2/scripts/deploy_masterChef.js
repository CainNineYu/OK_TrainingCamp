const { artifacts,network } = require('hardhat');
const SushiSwap = require(`../deployments/dev/${network.name}-SushiSwap.json`);

async function main() {
    const [deployer] = await ethers.getSigners();

     const MasterChef = await ethers.getContractFactory("MasterChef");
     const masterChef = await MasterChef.deploy(SushiSwap.address,"0xd6e9ccf74f5a43fae530d53c186acc2a9d4615e6",
     ethers.utils.parseEther('3'),0,1448239);
    await masterChef.deployed();
    console.log("部署地址", masterChef.address);
    
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});

