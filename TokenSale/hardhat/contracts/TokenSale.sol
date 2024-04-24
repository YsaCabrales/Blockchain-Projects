// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IWhitelist.sol";

contract TokenSale is ERC20 {
    uint256 public tokenPrice = 0.0001 ether;
    uint256 public tokensPerAddress = 10;
    uint256 public _totalSupply = totalSupply();
    uint256 public maxTotalSupply = 10000 * 10**18;

    address public owner;
    bool public presaleStarted;
    uint256 public presaleEndTime;

    IWhitelist public whitelist;
    mapping(address => uint256) public balances;
    mapping(address => bool) public presaleMinted;

    constructor(address _whitelistAddress)
        ERC20("Neko Token", "CATO") {
        whitelist = IWhitelist(_whitelistAddress);
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    function startPresale() public onlyOwner {
        presaleStarted = true;
        presaleEndTime = block.timestamp + 24 hours;
    }

    function presaleMint() public payable {
        require(presaleStarted && block.timestamp <= presaleEndTime, "Presale is not running.");
        require(whitelist.isWhitelisted(msg.sender), "You are not whitelisted.");
        require(presaleMinted[msg.sender] == false, "You have already minted your presale tokens.");

        uint256 mintPrice = tokensPerAddress * tokenPrice;
        require(msg.value >= mintPrice, "Amount sent is not correct.");

        uint256 tokensWithDecimals = tokensPerAddress * 10**18;
        _mint(msg.sender, tokensWithDecimals);
        balances[msg.sender] += tokensWithDecimals ;
        _totalSupply += tokensWithDecimals;
        presaleMinted[msg.sender] = true;
    }

    function publicMint(uint256 amountToMint) public payable {
        require(presaleStarted && block.timestamp >= presaleEndTime, "Presale has not ended.");
        require(amountToMint >= 1, "Must mint at least 1.");
        require(maxTotalSupply >= (_totalSupply + (amountToMint * 10**18)), "Cannot exceed maximum total supply.");

        uint256 mintPrice = amountToMint * tokenPrice;
        require(msg.value == mintPrice, "Ether sent is not correct.");

        uint256 tokensWithDecimals = amountToMint * 10**18;
        _mint(msg.sender, tokensWithDecimals);
        balances[msg.sender] += tokensWithDecimals;
        _totalSupply += tokensWithDecimals;
    }

    function withdraw() public onlyOwner {
        uint256 bal = address(this).balance;
        require(bal > 0, "Nothing to withdraw");

        (bool sent, ) = owner.call{value: bal}("");
        require(sent, "Failed to send balance");
    }
}