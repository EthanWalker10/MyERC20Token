// contracts/myToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {console} from "forge-std/console.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "OT") {
        // the operation equals transferring `initialSupply` from `address(0)` to msg.msg.sender
        // and Event is encapsulated in `_mint()` function
        _mint(msg.sender, initialSupply);
        console.log("miner's address:", block.coinbase);
    }
}
