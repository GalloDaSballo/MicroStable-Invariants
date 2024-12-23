
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import "src/MicroStable.sol";
import {MockOracle} from "./mocks/MockOracle.sol";
import {MockToken} from "./mocks/MockToken.sol";

abstract contract Setup is BaseSetup {

    Manager manager;
    ShUSD shUSD;

    MockToken weth;
    MockOracle oracle;

    function setup() internal virtual override {
      oracle = new MockOracle();
      weth = new MockToken();
      shUSD = new ShUSD(address(0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9));

      weth.mint(address(this), type(uint88).max);
      
      manager = new Manager(address(weth), address(shUSD), address(oracle));

      weth.approve(address(manager), type(uint256).max);

      assert(shUSD.manager() == address(manager));
    }
}
