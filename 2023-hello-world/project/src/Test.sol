// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract helloWorldSolve {
    constructor() payable {
        selfdestruct(payable(0x00000000219ab540356cBB839Cbe05303d7705Fa));
    }
}