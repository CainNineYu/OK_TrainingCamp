const { ethers, network } = require("hardhat");

const ERC20Addr = require(`../deployments/${network.name}/ERC20Token.json`)

async function parseTransferEvent(event) {
    //解析日志，创建对象
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
//获取历史事件，区块区间
    let filter = ERC20Token.filters.Transfer()
    filter.fromBlock = 1;
    filter.toBlock = 10;


    // let events = await ERC20Token.queryFilter(filter);
    //.gerLogs限制为2k左右，因为对服务器有压力
    let events = await ethers.provider.getLogs(filter);
    for (let i = 0; i < events.length; i++) {
        // console.log(events[i]);
        parseTransferEvent(events[i]);

    }
}

main()