// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTCollection is ERC721URIStorage, Ownable {
    using Strings for uint256;
    string _baseTokenURI; //store base token URI for the token metadata
    uint256 public _price = 0.01 ether; //price in ether in minting an NFT
    bool public _paused; //says whether cotract is paused
    uint256 public maxTokenIds = 18;
    uint256 public tokenIds; // counter that keeps track of the number of NFTs that have been minted

    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor(string memory baseURI) ERC721("PNKCollection", "PNK") {
        _baseTokenURI = baseURI;
    }

    function mint() public payable onlyWhenNotPaused() {
        require(tokenIds<maxTokenIds, "Maximum token limit reached");
        require(msg.value >= _price, "Incorrect amount of ether sent.");

        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    //returns the specific URI for a given token ID, concatenating the baseURI, token ID and file extension
    function tokenURI(uint256 tokenID) public view virtual override returns (string memory)  {
        require(_exists(tokenID), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, "/", tokenID.toString(), ".json")) : "" ;
    }

    // allows contract owner to pause or unpause the contract
    function setPaused(bool val) public onlyOwner() {
        _paused = val;
    }

    // withdraw all of the ether from the contract, withdraw the contract's balance
    function withdraw() public onlyOwner() {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");

        require(sent, "Failed to send ether");
    }

    //special function in solidity
    //handle incoming ether transactions
    receive() external payable {} //called when ether is sent to the contract
    fallback() external payable {} //called when the contract is called without a function name

}