// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployOurToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    address private account_0 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external returns (OurToken) {
        vm.startBroadcast(account_0);
        OurToken ourToken = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ourToken;
    }
}