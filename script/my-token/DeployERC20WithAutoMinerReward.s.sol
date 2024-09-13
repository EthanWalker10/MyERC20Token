// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {ERC20WithAutoMinerReward} from "../../src/my-token/ERC20WithAutoMinerReward.sol";

contract DeployERC20WithAutoMinerReward is Script {
    // uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    address private account_0 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external returns (ERC20WithAutoMinerReward) {
        vm.startBroadcast(account_0);
        ERC20WithAutoMinerReward eRC20WithAutoMinerReward = new ERC20WithAutoMinerReward();
        vm.stopBroadcast();
        return eRC20WithAutoMinerReward;
    }
}
