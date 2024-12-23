// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "lib/solmate/src/tokens/ERC20.sol";

contract MockToken is ERC20("Shafu USD", "shUSD", 18) {
    function mint(address to, uint256 amt) external {
        _mint(to, amt);
    }
}