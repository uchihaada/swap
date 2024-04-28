// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol"; 
import {SimpleSwap} from "../src/Swap.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";  
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleSwapTest is Test {
    ISwapRouter public  swapRouter;
    SimpleSwap public swap;
    address public constant usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
     address public constant FRAX = 0x853d955aCEf822Db058eb8505911ED77F175b99e;

    function setUp() public {
        swapRouter = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
        swap = new SimpleSwap(swapRouter);     
    }


    function test_SwapExactInputSingle() public {
        deal(address(this), 1000 ether);
        deal(usdc, address(this), 10 * 10**6);

        assertEq(address(this).balance,1000 ether,"Incorrect Balance");
        assertEq(IERC20(usdc).balanceOf(address(this)),10 * 10**6,"Line24");

        IERC20(usdc).approve(address(swap),10000000);
        uint256 amount = swap.swapExactInputSingle(1000000);
 
        assertEq(IERC20(FRAX).balanceOf(address(this)),amount,"Line32");
    }
}

        
