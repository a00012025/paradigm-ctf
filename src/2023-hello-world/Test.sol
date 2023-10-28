// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract ContractTest is Test {

  constructor() payable {
    // convert 0xeDf165A24Ccd69Bb06fc6F43775da410A85b6529 address to Challenge contract
    address(0xeDf165A24Ccd69Bb06fc6F43775da410A85b6529).call{value: 0.1 ether}("");
  }

    function setUp() public {
    }

    function testExploit() public {
        vm.createSelectFork(vm.rpcUrl("paradigm"));
        

    }
}
