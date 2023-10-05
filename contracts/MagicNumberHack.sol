// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IMagicNum {
    function solver() external view returns (address);
    function setSolver(address) external;
}

contract MagicNumberHack {
    constructor(IMagicNum targetAddress) {
        // create memory array of bytes containiner the bytecode solution.
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address bytecodeAddress;

        // manually deploy the low-level solver contract
        assembly {            
            // create(value, offset, size)
            // value = 0, no value passed in.
            // offset = Points to the start of the actual bytecode.
            // The first 32 bytes stores the length of the array, so skip first 32 bytes which is 0x20.
            // size of "69602a60005260206000f3600052600a6016f3" is 38 characters long, or 19 bytes (0x13).
            bytecodeAddress := create(0, add(bytecode, 0x20), 0x13)
        }

        // Reverts unless the bytecode contract was successfully deployed.
        require(bytecodeAddress != address(0));

        targetAddress.setSolver(bytecodeAddress);
    }
}

/*
// Target Contract

contract MagicNum {

  address public solver;

  constructor() {}

  function setSolver(address _solver) public {
    solver = _solver;
  }
// 42 is the answer.
}
*/