// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalculatorV2 {
    uint256 public result;
    address public user;

    function solve(uint256 num1, uint256 num2) public returns (uint256){
        // Add the numbers and update the result
        result = num1 - num2;
        // Assign the user calling the function to "user" variable
        user = msg.sender;
        return result;
    }
}