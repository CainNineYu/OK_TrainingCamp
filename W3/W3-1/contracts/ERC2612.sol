//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract ERC2612 is ERC20Permit {

    constructor() ERC20("ERC2612", "ERC2612") ERC20Permit("ERC2612") {
        _mint(msg.sender, 2612 * 10 ** 18);
    }
        // //防止转帐后锁住
    // function send(address recipient,uint256 amount,bytes calldata exData) external return (bool){
    //     _transfer(msg.sender,recipient,amount);

    //     if(recipient.isContract()){
    //         bool rv = TokenRecipient(recipient).tokensReverved(msg.sender,amount,exData);
    //         require(rv,"No tokensReceived");
    //     }
    // }
}