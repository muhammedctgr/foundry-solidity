//SPDX-License-Identifier: MIT

pragma solidity ^0.8.29;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTool} from "foundry-devops/src/DevOpsTool.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;
    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        fundFundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log(
            "Funded contract at address: %s with %s wei",
            mostRecentlyDeployed,
            SEND_VALUE
        );
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTool.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        FundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script {}
