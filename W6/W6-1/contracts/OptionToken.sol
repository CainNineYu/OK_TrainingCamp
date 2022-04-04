//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract OptionToken is ERC20,Ownable{
    using SafeERC20 for IERC20;

    uint public price;
    uint public exerciseDate;
    uint public constant exerciseDateDay = 1 days;
    address public udscToken;

    constructor(address usdc) Erc20("OptionToken","OPT"){
        udscToken = usdc;
        price = 5000;
        exerciseDate = block.timestamp + 365 days;
    }
    //出售期权
    function mint() external payable onlyOwner {
        _mint(msg.sender, 10 * msg.value);
    }
//行权日期
    function setExercise(uint amount) external {
        require(block.timestamp >= exerciseDate && block.timestamp < exerciseDate + exerciseDateDay, "Invalid Time!!");
        
        _burn(msg.sender, amount);
        uint needUsdcAmount = price * amount;
//授权给调用行权者，数量为needUsdcAmount
        IERC20(udscToken).safeTransferFrom(msg.sender, address(this), needUsdcAmount);
        safeTransferETH(msg.sender, amount);
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
    }

    function burnAll() external onlyOwner {
        require(block.timestamp >= exerciseDate + exerciseDateDay, "Not Exercise");
        uint usdcAmount = IERC20(udscToken).balanceOf(address(this));
        IERC20(udscToken).safeTransfer(msg.sender, usdcAmount);
        selfdestruct(payable(msg.sender));
  }

}