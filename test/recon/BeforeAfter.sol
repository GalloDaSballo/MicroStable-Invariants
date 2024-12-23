
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";

abstract contract BeforeAfter is Setup {

    struct Vars {
        bool isLiquidatable;
    }

    Vars internal _before;
    Vars internal _after;

    modifier beforeAfter {
        __before();
        _;
        __after();
    }

    function __before() internal {
        _before.isLiquidatable = manager.collatRatio(address(this)) < manager.MIN_COLLAT_RATIO();
    }

    function __after() internal {
        _after.isLiquidatable = manager.collatRatio(address(this)) < manager.MIN_COLLAT_RATIO();
    }
}
