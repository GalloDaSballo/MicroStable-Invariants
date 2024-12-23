
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup} from "./Setup.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {

    /**
        When you burn tokens `address2minted` is reduced according
     */

    // SUM(`address2minted`) == totalSupply?
    function property_check_supply() public {
        // Sum of all address2minted
        eq(
            manager.address2minted(address(this)),
            shUSD.totalSupply(), 
            "Sum of minted matches total supply"
        );
    }
    
    // Stateful fuzz
    // When a liquidation happens, `address2deposit` and `address2minted` == 0

    function property_never_self_liquidatable() public {
        if(!_before.isLiquidatable) {
            t(!_after.isLiquidatable, "No user action allows you to become liquidatable");
        }
    }
}
