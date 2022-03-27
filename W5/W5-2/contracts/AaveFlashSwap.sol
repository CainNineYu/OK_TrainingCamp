pragma solidity ^0.8.0;

import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Callee.sol';

import './libraries/UniswapV2Library.sol';
import './interfaces/V1/IUniswapV1Factory.sol';
import './interfaces/V1/IUniswapV1Exchange.sol';
import './interfaces/IUniswapV2Router01.sol';
import './interfaces/IERC20.sol';
import './interfaces/IWETH.sol';
import './interfaces/ISwapRouter.sol';
import './interfaces/ISwapRouter.sol';

contract AaveFlashSwap is IUniswapV2Callee, ISwapRouter,IFlashLoanSimpleReceiver{

    IUniswapV1Factory immutable factoryV1;
    address immutable factory;
    IWETH immutable WETH;

    constructor(address _factory, address _factoryV1, address router) public {
        factoryV1 = IUniswapV1Factory(_factoryV1);
        factory = _factory;
        WETH = IWETH(IUniswapV2Router01(router).WETH());
    }

    // needs to accept ETH from any V1 exchange and WETH. ideally this could be enforced, as in the router,
    // but it's not possible because it requires a call to the v1 factory, which takes too much gas
    receive() external payable {}

    // gets tokens/WETH via a V2 flash swap, swaps for the ETH/tokens on V1, repays V2, and keeps the rest!
    // 实现IUniswapV2Callee中uniswapV2Call方法，data看需要数据就传入什么数据
    function executeOperation(    address asset,uint256 amount,uint256 premium,address initiator,bytes calldata params) external override {
        address[] memory path = new address[](2);
        //收到的token
        uint amountToken;
        uint amountETH;
        { // scope for token{0,1}, avoids stack too deep errors
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();
        assert(msg.sender == UniswapV2Library.pairFor(factory, token0, token1)); // ensure that msg.sender is actually a V2 pair
        assert(amount0 == 0 || amount1 == 0); // this strategy is unidirectional
        path[0] = amount0 == 0 ? token0 : token1;
        path[1] = amount0 == 0 ? token1 : token0;
        amountToken = token0 == address(WETH) ? amount1 : amount0;
        amountETH = token0 == address(WETH) ? amount0 : amount1;
        }

        assert(path[0] == address(WETH) || path[1] == address(WETH)); // this strategy only works with a V2 WETH pair
        IERC20 token = IERC20(path[0] == address(WETH) ? path[1] : path[0]);


            (uint minETH) = abi.decode(data, (uint)); // slippage parameter for V1, passed in by caller
            // 去另外交易所套利
            IUniswapV1Exchange exchangeV1 = IUniswapV1Exchange(factoryV1.getExchange(address(token))); // get V1 exchange
// 授权给 Pool 合约所借⾦额 + ⼿续费
            token.approve(address(exchangeV1), amountToken);

        // token A 在 Uniswap V2 中交易兑换 token B
        uint256 tokenB = ISwapRouter(exchangeV1).exactInputSingle(
            ISwapRouter.ExactInputSingleParams(token0,token1,0,address(this),block.timestamp,amountToken,0,0)
        );



        // token B 在 Uniswap V3 中交易兑换 token A
        uint256 kokenA = ISwapRouter(exchangeV1).exactInputSingle(
            ISwapRouter.ExactInputSingleParams(token0,token1,0,address(this),block.timestamp,amountToken,0,0)
        );


        //返回tokenA还款给AAVE




            // 套利所得币重新返回调用者
            assert(token.transfer(msg.sender, amountRequired)); // return tokens to V2 pair
            //如果套利成功，就会把所得币转给调用者
            assert(token.transfer(sender, amountReceived - amountRequired)); // keep the rest! (tokens)
        }
    }
    
}