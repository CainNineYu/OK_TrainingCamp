//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract ERC2612 is ERC20Permit {
    // mapping(address => uint256) private _balances;

    // uint256 private _totalSupply;

    constructor(address _address) ERC20("ERC2612", "ERC2612") ERC20Permit("ERC2612") {
        _mint(_address, 2612 * 10 ** 18);
    }

    //     function _mint(address account, uint256 amount) internal override {
    //     _totalSupply += amount;
    //     _balances[account] += amount;
    //     console.log("Balance '%s' Address '%s'", _balances[account],msg.sender);
    // }
        // //防止转帐后锁住
    // function send(address recipient,uint256 amount,bytes calldata exData) external return (bool){
    //     _transfer(msg.sender,recipient,amount);

    //     if(recipient.isContract()){
    //         bool rv = TokenRecipient(recipient).tokensReverved(msg.sender,amount,exData);
    //         require(rv,"No tokensReceived");
    //     }
    // }
}