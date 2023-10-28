#!/bin/bash

forge create --rpc-url "http://hello-world.challenges.paradigm.xyz:8545/2bbfaca3-3ac1-4b1e-9c4b-2c3016572215/main" --private-key "0xdc236305da52d3fdec0113301832ea42055b5f3fb3ae3a9cf907feec04bd8393" --value 15ether src/2023-hello-world/Exploit.sol:HelloWorldSolve
