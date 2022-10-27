// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

import "./Utils/ERC721URIStorage.sol";
import "./Utils/Ownable.sol";
import "./Libraries/Strings.sol";
import "hardhat/console.sol";

contract RuneNFT is ERC721URIStorage, Ownable {
    using Strings for uint256;

    uint256 private mintPrice = 100 ether;
    string _baseTokenURI;
    uint256 private tokenIds;

    mapping(address => uint256) public mintedWallets;
    mapping(string => uint256) public mintedRunes;
    mapping(uint256 => string) internal tokenName;

    event NewNFTMinted(address indexed buyer, uint256 indexed tokenId);

    constructor(string memory baseURI) payable ERC721("Rune NFTs", "RUNES") {
        _baseTokenURI = baseURI;
        console.log("Deployment successful");
    }

    function getPrice() public view returns (uint256) {
        return mintPrice;
    }

    function getMintedTokens() public view returns (uint256) {
        return tokenIds;
    }

    function _baseURI() internal view override returns(string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "RuneNFT: token does not exist");

        string memory baseURI = _baseURI();
        string memory _tokenName = tokenName[tokenId];

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, _tokenName, ".json")) : ""; 
    }

    function mintNFT(string memory _tokenURI) external payable {
        require(msg.value >= mintPrice, "RuneNFT: Not enough ether sent");

        uint256 newItemId = tokenIds;
        tokenName[newItemId] = _tokenURI;
        string memory baseURI = _baseURI();
        string memory finalToken = string(abi.encodePacked(baseURI, _tokenURI, ".json"));

        _mint(_msgSender(), newItemId);
        _setTokenURI(newItemId, finalToken);
        emit NewNFTMinted(_msgSender(), newItemId);

        mintedWallets[_msgSender()]++;
        tokenIds++;
        mintedRunes[_tokenURI]++;
        console.log(newItemId);
    }

    function mintedSingleRune(string memory _name) public view returns (uint256) {
        return mintedRunes[_name];
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;

        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "RuneNFT: failed to withdraw");
    }

    receive() external payable {}

    fallback() external payable {}
}