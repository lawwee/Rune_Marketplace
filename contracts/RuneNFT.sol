//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract RuneNFT is ERC721URIStorage, Ownable {

    uint256 public totalSupply;
    uint256 public  mintPrice = 0.01 ether;

    mapping(address => uint256) public mintedWallets;
    mapping(string => uint256) public mintedRune;

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() payable ERC721("The Rune Project", "RUNE") {
        console.log("Lawwee is here again");
    }

    function mintNft(string memory _tokenUri) external payable {
        require(msg.value == mintPrice, "Not enough money");

        uint256 newItemId = totalSupply;

        string memory finalToken = string(abi.encodePacked("ipfs://YOUR_CID_HERE/", _tokenUri, ".json"));

        console.log(finalToken);

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalToken);
        emit NewNFTMinted(msg.sender, newItemId);

        mintedWallets[msg.sender]++;
        totalSupply++;
        mintedRune[_tokenUri]++;
        console.log("An NFT w/ ID %s has been minted to %s:", newItemId, msg.sender);
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "failed to withdraw");
    }

    function totalMintedRunes() public view returns(uint256) {
        console.log("we have a total of %d minted runes", totalSupply);
        return totalSupply;
    }

    function totalSingleRune(string memory _name) public view returns (uint256) {
        return mintedRune[_name];
    }
}