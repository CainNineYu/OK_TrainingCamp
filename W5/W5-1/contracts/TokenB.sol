//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

contract TokenB is ERC20 {
    constructor() ERC20("TokenB", "TokenB") { 
        _mint(msg.sender, 1000*10**18);
        } 
        
        function mint(address _adddress, uint256 _amount) public {
            _mint(_adddress,_amount);
            }
}