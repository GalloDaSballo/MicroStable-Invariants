
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";
import {vm} from "@chimera/Hevm.sol";

abstract contract TargetFunctions is BaseTargetFunctions, Properties {

    function manager_burn(uint256 amount) public beforeAfter {
        manager.burn(amount);
    }

    function manager_deposit(uint256 amount) public beforeAfter {
        manager.deposit(amount);
    }

    function manager_liquidate(address user) public beforeAfter {
        manager.liquidate(user);

        eq(manager.address2deposit(user), 0, "Must have reset");
        eq(manager.address2minted(user), 0, "Must have reset");
    }

    function manager_mint(uint256 amount) public beforeAfter {
        manager.mint(amount);
    }

    function manager_withdraw(uint256 amount) public beforeAfter {
        manager.withdraw(amount);
    }

    function mockOracle_setAnswer(uint256 price) public {
        oracle.setAnswer(price);
    }

    function doomsday_cannot_over_borrow(uint256 amt) public {
        uint256 cr = manager.collatRatio(address(this));
        require(cr <= manager.MIN_COLLAT_RATIO());

        try manager.mint(amt) {
            t(false, "doomsday_cannot_over_borrow");
        } catch {

        }


        revert("Stateless test");
    }
}
