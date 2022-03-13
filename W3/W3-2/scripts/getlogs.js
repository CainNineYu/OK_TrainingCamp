const { ethers, network } = require("hardhat");

const ERC20Addr = require(`../deployments/${network.name}/ERC20Token.json`)

async function parseTransferEvent(event) {
    const TransferEvent = new ethers.utils.Interface(["event Transfer(address indexed from,address indexed to,uint256 value)"]);
    let decodedData = TransferEvent.parseLog(event);
    console.log("from:" + decodedData.args.from);
    console.log("to:" + decodedData.args.to);
    console.log("value:" + decodedData.args.value.toString());
}

async function main() {
    let [owner, second] = await ethers.getSigners();
    let ERC20Token = await ethers.getContractAt("ERC20Token",
        ERC20Addr.address,
        owner);

    let filter = ERC20Token.filters.Transfer()
    filter.fromBlock = 1;
    filter.toBlock = 10;


    // let events = await ERC20Token.queryFilter(filter);
    let events = await ethers.provider.getLogs(filter);
    for (let i = 0; i < events.length; i++) {
        // console.log(events[i]);
        parseTransferEvent(events[i]);

    }
}

main()