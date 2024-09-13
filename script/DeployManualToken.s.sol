// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {ManualToken} from "../src/manual-token/ManualToken.sol";

contract DeployManualToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    address private account_0 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external returns (ManualToken) {
        vm.startBroadcast(account_0);
        ManualToken manualToken = new ManualToken(INITIAL_SUPPLY, "Ethan's token", "Ethan Walker");
        vm.stopBroadcast();
        return manualToken;
    }
}
