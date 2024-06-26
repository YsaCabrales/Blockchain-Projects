// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SimpleNFT is ERC721URIStorage, Ownable {
    // using Counters for Counters.Counter;
    // Counters.Counter private _tokenIdCounter;

    // constructor() ERC721("MySimpleNFT", "MSN") {}

    // function safeMint(address to, string memory uri) public onlyOwner {
    //     uint256 tokenId = _tokenIdCounter.current(); 
    //     _tokenIdCounter.increment();
    //     _safeMint(to, tokenId);
    //     _setTokenURI(tokenId, uri);
    // }

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

   constructor() ERC721("MySimpleNFT", "MSN") {}

    function mintNFT(address to, string memory tokenURI) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current(); 
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }
}