// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MockOracle {
    uint256 public latestAnswer;

    // Not testing for revert
    // Not mocking for arbitrage

    function setAnswer(uint256 price) external {
        latestAnswer = price;
    }
}