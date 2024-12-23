
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";
import {vm} from "@chimera/Hevm.sol";

abstract contract TargetFunctions is BaseTargetFunctions, Properties, BeforeAfter {

    function manager_burn(uint256 amount) public {
        manager.burn(amount);
    }

    function manager_deposit(uint256 amount) public {
        manager.deposit(amount);
    }

    function manager_liquidate(address user) public {
        manager.liquidate(user);
    }

    function manager_mint(uint256 amount) public {
        manager.mint(amount);
    }

    function manager_withdraw(uint256 amount) public {
        manager.withdraw(amount);
    }
}
