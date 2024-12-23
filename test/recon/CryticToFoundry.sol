
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
    }

    // forge test --match-test testDemo -vv
    function testDemo() public {
        // TODO: Given any target function and foundry assert, test your results

        console.log("shUSD", address(shUSD));
        console.log("manager", address(manager));

        assertEq(shUSD.manager(), address(manager), "same addy");

        manager_deposit(1e18);
        mockOracle_setAnswer(1e18);


        manager_mint(1);

    }

    // forge test --match-test test_property_check_supply_0 -vv 
 function test_property_check_supply_0() public {

    manager_deposit(11410129391443965370);

    mockOracle_setAnswer(13150837);

    manager_mint(1);

    property_check_supply();

 }

 // forge test --match-test test_doomsday_cannot_over_borrow_0 -vv 
 function test_doomsday_cannot_over_borrow_0() public {

    manager_mint(1);

    doomsday_cannot_over_borrow(0);

 }

 // forge test --match-test test_property_never_self_liquidatable_0 -vv 
 function test_property_never_self_liquidatable_0() public {

    manager_deposit(5042783975015330162);

    mockOracle_setAnswer(29840833);

    manager_mint(1);

    mockOracle_setAnswer(0);

    property_never_self_liquidatable();

 }
}
