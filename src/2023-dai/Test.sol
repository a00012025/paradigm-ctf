// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Challenge.sol";
import "./SystemConfiguration.sol";
import "./AccountManager.sol";
import {Account as Acct} from "./Account.sol";

contract DaiTest is Test {
    function setUp() public {}

    function test_exploitDai() public {
        SystemConfiguration configuration = new SystemConfiguration();
        AccountManager manager = new AccountManager(configuration);

        configuration.updateAccountManager(address(manager));
        configuration.updateStablecoin(address(new Stablecoin(configuration)));
        configuration.updateAccountImplementation(address(new Acct()));
        configuration.updateEthUsdPriceFeed(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );

        configuration.updateSystemContract(address(manager), true);

        Challenge challenge = new Challenge(configuration);
        console.log("Challenge address: %s", address(challenge));

        address[] memory recoveryAddresses = new address[](1);
        recoveryAddresses[0] = address(this);
        Acct myAccount = manager.openAccount(address(this), recoveryAddresses);
        console.log("Account address: %s", address(myAccount));
        manager.mintStablecoins(myAccount, 1000, "");
    }

    receive() external payable {}
}
