
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import "src/MicroStable.sol";

abstract contract Setup is BaseSetup {

    Manager manager;

    function setup() internal virtual override {
      manager = new Manager(address(0), address(0), address(0)); // TODO: Add parameters here
    }
}
