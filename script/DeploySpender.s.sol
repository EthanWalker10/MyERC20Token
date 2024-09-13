// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {Spender} from "../src/manual-token/Spender.sol";

// Contract Address: 0x8464135c8F25Da09e49BC8782676a84730C318bC
contract DeploySpender_1 is Script {
    address private s_manualToken = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
    address private s_account_1 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    function run() external returns (Spender) {
        vm.startBroadcast(s_account_1);
        Spender spender = new Spender(s_manualToken);
        vm.stopBroadcast();

        return spender;
    }
}

// Contract Address: 0x663F3ad617193148711d28f5334eE4Ed07016602
contract DeploySpender_2 is Script {
    address private s_manualToken = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
    address private s_account_2 = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

    function run() external returns (Spender) {
        vm.startBroadcast(s_account_2);
        Spender spender = new Spender(s_manualToken);
        vm.stopBroadcast();

        return spender;
    }
}
