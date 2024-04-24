// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractProxy {
    int256 public myResult;
    address public calculator;

    constructor(address _calculator) {
        calculator = _calculator;
    }

    function solveTwoNumbers(uint256 a, uint256 b) public returns (int256) {
        (bool success, bytes memory result) = calculator.delegatecall(abi.encodeWithSignature("solve(uint256,uint256)", a, b));
        require(success, "The call to calculator contract failed");
        myResult = abi.decode(result, (int256));
        return myResult;
    }

    function upgradeCalculator(address _calculator) public {
        calculator = _calculator;
    }

    function getCalculatorAddress() public view returns (address) {
        return calculator;
    }
}