//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {

    constructor() ERC20("MyERC20", "MyERC20") {
        _mint(msg.sender, 1000 * 10 ** 18);
    }
    //     // //防止转帐后锁住
    // function send(address recipient,uint256 amount,bytes calldata exData) external returns (bool){
    //     _transfer(msg.sender,recipient,amount);

    //     if(recipient.isContract()){
    //         bool rv = TokenRecipient(recipient).tokensReverved(msg.sender,amount,exData);
    //         require(rv,"No tokensReceived");
    //     }
    //     return true;
    // }

}