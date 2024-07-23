// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract GameNFT is ERC721Enumerable{
    using Strings for uint256;
    string baseTokenURI;

    uint256 public totalNFTSupply = 10000;

    uint256 public numNFTsMinted;

    constructor (string memory baseURI) ERC721("GameNFT", "GNFT"){
        baseTokenURI = baseURI;
    }

    function mint() public payable {
        require(numNFTsMinted < totalNFTSupply, "Exceed maximum LW3Punks supply");
        numNFTsMinted += 1;
        _safeMint(msg.sender, numNFTsMinted);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Enter correct URI");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

}
