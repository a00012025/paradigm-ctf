// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Challenge.sol";
import "./Split.sol";

contract OneHundredPercentTest is Test {
    function setUp() public {}

    function test_exploit100Percent() public {
        Split split = new Split();

        address[] memory addrs = new address[](2);
        addrs[0] = address(0x000000000000000000000000000000000000dEaD);
        addrs[0] = address(0x000000000000000000000000000000000000bEEF);
        uint32[] memory percents = new uint32[](2);
        percents[0] = 5e5;
        percents[1] = 5e5;

        uint256 id = split.createSplit(addrs, percents, 0);

        Split.SplitData memory splitData = split.splitsById(id);
        splitData.wallet.deposit{value: 100 ether}();

        challenge = address(new Challenge(split));
        assertEq(challenge.isSolved(), false);
    }
}
