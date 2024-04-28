// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;
pragma abicoder v2;


import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";      
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";   

contract SimpleSwap {
    ISwapRouter public  swapRouter;

    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant FRAX = 0x853d955aCEf822Db058eb8505911ED77F175b99e;
    // address public constant LINK = 0x779877A7B0D9E8603169DdbD7836e478b4624789;
    // address public constant WETH = 0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14;
    // address public constant GLM = 0x71432DD1ae7DB41706ee6a22148446087BdD0906;
    // address public constant DAI = 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357;
    uint24 public constant poolFee = 500;

    constructor(ISwapRouter _router){
        swapRouter = _router;
        // 0x3fC91A3afd70395Cd496C647d5a6CC9D4B2b7FAD
    }
    function setSwapRouter (ISwapRouter _router) public  {
        swapRouter = _router;
    }

    function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut){
        

 
        TransferHelper.safeTransferFrom(USDC, msg.sender, address(this), amountIn);
        TransferHelper.safeApprove(USDC,address(swapRouter),amountIn);

        ISwapRouter.ExactInputSingleParams memory params =
         ISwapRouter.ExactInputSingleParams ({
            tokenIn : USDC,
            tokenOut : FRAX,
            fee : poolFee,
            recipient: msg.sender,
            deadline : block.timestamp,
            amountIn : amountIn,
            amountOutMinimum : 0,
            sqrtPriceLimitX96 : 0
         });

        amountOut = swapRouter.exactInputSingle(params);
    }




}