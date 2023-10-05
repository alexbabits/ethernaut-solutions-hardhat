// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ForceHack {
    constructor(address payable _target) payable {
        // uncomment to solve, commented out because annoying warning
        //selfdestruct(_target);
    }
}


contract Force {
// it's empty
}