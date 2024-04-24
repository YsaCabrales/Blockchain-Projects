// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    uint public result;
    address public user;

    constructor() {
        user = msg.sender;
    }

    function solve(uint num1, uint num2) public {
        // Add the numbers and update the result
        result = num1 + num2;
        // Assign the user calling the function to "user" variable
        user = msg.sender;
    }
}

// npx hardhat compile
// npx hardhat run scripts/deploy.js --network mumbai  