// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Lootbox is ERC721URIStorage {
    uint public boxPrice = 0.001 ether; //price of single lootbox in ether
    uint public maxItems = 35; //max number of items that can be minted from the lootbox

    mapping (address => uint) public boxes; // number of lootboxes owned by each addresss

    constructor() ERC721("LootboxGame", "LBG") {}

    function _baseURI() internal view virtual override returns (string memory){
        return "ipfs://QmYG4p56PusVwBAzCHGzfcDz4e7tdsqDnBBwAgRGuayZzM/";
    }

    function tokenURI(uint tokenId) public view virtual override returns(string memory) {
        string memory baseURI = _baseURI();
        return
        bytes(baseURI).length > 0
            ? string(
                abi.encodePacked(
                    baseURI,
                    Strings.toString(tokenId),
                    ".json"
                )
            ): "";
    }

    function buyBox() public payable {
        require(msg.value == boxPrice, "Send the correct amount of to buy a loot box.");
        boxes[msg.sender]++;
    }

    function openBox() public {
        //check if the sender owns at least one box
        require(boxes[msg.sender] > 0, 'You need to have at least one loot box.');

        uint256 randomTokenId = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender)))% maxItems;
        mintEquipment(tokenURI(randomTokenId), randomTokenId);
    }

    function mintEquipment(string memory _tokenURI, uint tokenId) internal returns (uint256){
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        return tokenId;
   }
}