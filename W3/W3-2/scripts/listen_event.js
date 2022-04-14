const { ethers, network } = require("hardhat");

const ERC20Addr = require(`../deployments/${network.name}/ERC20Token.json`)


function getFunctionID() {
    let transferTopic = ethers.utils.keccak256(
      ethers.utils.toUtf8Bytes("Transfer(address,address,uint256)"));
    console.log("transferTopic:" + transferTopic)
    let id = ethers.utils.id("Transfer(address,address,uint256)")
    console.log("Transfer:" + id);
}

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

    // let filter = ERC20Token.filters.Transfer(owner.address)
    // let filter = ERC20Token.filters.Transfer(null, owner.address)

    // logsFrom = await erc20.queryFilter(filter, -10, "latest");

    // filter = {
        //指定监听地址和事件
    //     address: ERC20Addr.address,
    //     topics: [
        //和topic一样
    //         ethers.utils.id("Transfer(address,address,uint256)")
    //     ]
    // }


//实时获取日志信息
    ethers.provider.on(filter, (event) => {

      console.log(event)

        // const decodedEvent = ERC20Token.interface.decodeEventLog(
        //     "Transfer", //
        //     event.data,
        //     event.topics
        // );
        // console.log(decodedEvent);

        parseTransferEvent(event);
    })
}

main()