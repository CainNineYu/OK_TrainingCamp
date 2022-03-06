// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {

    address public owner;
    mapping(address => TransactionRecords[]) public user;
    mapping(address => uint256) public balance;
    // uint private balance = 0;
    struct TransactionRecords {
        uint256 amount;
        uint256 time;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    //充值
    receive() external payable {
        user[msg.sender].push(
           TransactionRecords({amount: msg.value, time: block.timestamp})
        );
        balance[msg.sender] += msg.value;
    }

    //查询充值记录
    function getRecords(address _addr)
        public view returns (TransactionRecords[] memory){
        return user[_addr];
    }
    
    //提现全部ETH
    function  withdraw() public onlyOwner {
        uint256 oldBalance = address(this).balance;
        payable(owner).transfer(oldBalance);
    }
}