const { artifacts,network } = require('hardhat');
async function main() {
    const [deployer] = await ethers.getSigners();
     const SushiSwap = await ethers.getContractFactory("SushiSwap");
     const SushiSwap = await SushiSwap.deploy();
    await SushiSwap.deployed();
    let artifact = await artifacts.readArtifact("SushiSwap");
    await writeAbiAddr(artifact, SushiSwap.address, "SushiSwap", network.name);
        console.log("部署地址", SushiSwap.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});
