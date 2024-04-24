// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MyToken is ERC20, ERC721Holder, Ownable {
    IERC721 public nft;
    uint256 public EMISSION_RATE = (50 * 10 ** decimals()) / 1 days;
    mapping(uint256 => address) public tokenOwnerOf;
    mapping(uint256 tokenId => uint256) public tokenStakedAt;

    constructor(address _nft) ERC20("NekoToken", "NEKO") {
    nft = IERC721(_nft);
    }

    function stake(uint256 tokenId) external {
        nft.safeTransferFrom(msg.sender, address(this), tokenId); //implies that the token is being staked to the contract

        tokenOwnerOf[tokenId] = msg.sender;
        tokenStakedAt[tokenId] = block.timestamp;
    }

    function calculateToken(uint256 tokenId) public view returns(uint256){
        uint256 timeElapsed = block.timestamp - tokenStakedAt[tokenId];
        return EMISSION_RATE * timeElapsed;
    }
    
    function unstake(uint256 tokenId) external {
        require(tokenOwnerOf[tokenId] == msg.sender, "Can't unstake. You are not the owner of this NFT.");
        _mint(msg.sender, calculateToken(tokenId));
        nft.safeTransferFrom(address(this), msg.sender, tokenId);
        delete tokenOwnerOf[tokenId];
        delete tokenStakedAt[tokenId];
    }
}