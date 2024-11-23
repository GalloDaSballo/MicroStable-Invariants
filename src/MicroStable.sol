// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "lib/solmate/src/tokens/ERC20.sol";

interface Oracle { function latestAnswer() external view returns (uint); }

contract ShUSD is ERC20("Shafu USD", "shUSD", 18) {
  address public manager;

  constructor(address _manager) { manager = _manager; }

  modifier onlyManager() {
    require(manager == msg.sender);
    _;
  }

  function mint(address to,   uint amount) public onlyManager { _mint(to,   amount); }
  function burn(address from, uint amount) public onlyManager { _burn(from, amount); }
}

contract Manager {
  uint public constant MIN_COLLAT_RATIO = 1.5e18;

  ERC20 public weth;
  ShUSD public shUSD;

  Oracle public oracle;

  mapping(address => uint) public address2deposit;
  mapping(address => uint) public address2minted;

  constructor(address _weth, address _shUSD, address _oracle) {
    weth   = ERC20(_weth);
    shUSD  = ShUSD(_shUSD);
    oracle = Oracle(_oracle);
  }

  function deposit(uint amount) public {
    weth.transferFrom(msg.sender, address(this), amount);
    address2deposit[msg.sender] += amount;
  }

  function withdraw(uint amount) public {
    address2deposit[msg.sender] -= amount;
    require(collatRatio(msg.sender) >= MIN_COLLAT_RATIO);
    weth.transfer(msg.sender, amount);
  }

  function burn(uint amount) public {
    address2minted[msg.sender] -= amount;
    shUSD.burn(msg.sender, amount);
  }

  function mint(uint amount) public {
    address2minted[msg.sender] += amount;
    require(collatRatio(msg.sender) >= MIN_COLLAT_RATIO);
    shUSD.mint(msg.sender, amount);
  }

  function liquidate(address user) public {
    require(collatRatio(user) < MIN_COLLAT_RATIO);
    shUSD.burn(user, address2minted[user]);
    weth.transfer(user, address2deposit[user]);
    address2deposit[user] = 0;
    address2minted[user] = 0;
  }

  function collatRatio(address user) public view returns (uint) {
    uint mintedDyad = address2minted[user];
    if (mintedDyad == 0) return type(uint256).max;
    uint totalValue = address2deposit[user] * oracle.latestAnswer() / 1e18;
    return totalValue / mintedDyad;
  }
}
