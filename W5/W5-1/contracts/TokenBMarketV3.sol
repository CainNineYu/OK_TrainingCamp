//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/INonfungiblePositionManager.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract TokenBMarketV3 {
    using SafeERC20 for IERC20;

    address public myToken;
    address public router;
    address public weth;

    constructor(address _token, address _router, address _weth) {
        myToken = _token;
        router = _router;
        weth = _weth;
    }

    // 添加流动性
    function mint(uint tokenAmount) public payable {
        IERC20(myToken).safeTransferFrom(msg.sender, address(this),tokenAmount);
        IERC20(myToken).safeApprove(router, tokenAmount);
//新增流动性
        INonfungiblePositionManager(router).mint(INonfungiblePositionManager.MintParams(
            myToken,router,0,0,100,10,1000,0,0,address(this),block.timestamp+1000
            )
        );
    }
}