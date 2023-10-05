// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RecoveryHelper {
    // sender is address of the Recovery contract
    function recover(address sender) external pure returns (address) {
        // nounce1 uses bytes1(0x01) as part of it's calculation.
        bytes32 hashed = keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01)));
        address addr = address(uint160(uint256(hashed)));
        return addr;
    }
}

/*
// Target contracts
// NOTE: Uncomment and compile SimpleToken to grab the ABI when needed.
// I've commented it out since selfdestruct is depricated and I'm annoyed at the warning.
contract Recovery {

  //generate tokens
  function generateToken(string memory _name, uint256 _initialSupply) public {
    new SimpleToken(_name, msg.sender, _initialSupply);
  
  }
}

contract SimpleToken {

  string public name;
  mapping (address => uint) public balances;

  // constructor
  constructor(string memory _name, address _creator, uint256 _initialSupply) {
    name = _name;
    balances[_creator] = _initialSupply;
  }

  // collect ether in return for tokens
  receive() external payable {
    balances[msg.sender] = msg.value * 10;
  }

  // allow transfers of tokens
  function transfer(address _to, uint _amount) public { 
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] = balances[msg.sender] - _amount;
    balances[_to] = _amount;
  }

  // clean up after ourselves
  function destroy(address payable _to) public {
    selfdestruct(_to);
  }
}
*/