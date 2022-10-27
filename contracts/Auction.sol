// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

import "./RuneNFT.sol";
import "hardhat/console.sol";

contract Auction is RuneNFT {
    mapping(uint256 => uint256) private _highestBid;
    mapping(uint256 => address) private _highestBidder;
    mapping(uint256 => bool) private AUCTION_IN_SESSION;
    mapping(uint256 => bool) private WITH_RESERVE;

    event NewAuction(uint256 indexed tokenId, address indexed seller, uint256 indexed startBid);
    event AuctionEnded(uint256 indexed tokenId, address indexed seller, uint256 indexed finalBid);
    event AuctionCancelled(uint256 indexed tokenId, address indexed seller);
    event NewBid(uint256 indexed tokenId, uint256 indexed price, address indexed owner);

    constructor(string memory baseURI) RuneNFT(baseURI) {
        console.log("Auction Contract deployed");
    }

    modifier nftOwner(uint256 _tokenId) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        require(_msgSender() == _ownerOf(_tokenId), "Auction: Caller does not own contract");
        _;
    }

    function _bid(uint256 _tokenId, uint256 _bidPrice) private returns(bool) {
        require(_bidPrice >= 0, "Auction: Bid price cannot be 0");

        _highestBid[_tokenId] = _bidPrice;
        _highestBidder[_tokenId] = _msgSender();
        emit NewBid(_tokenId, _bidPrice, _msgSender());
        return true;
    }

    function setStartBid(uint256 _tokenId) nftOwner(_tokenId) payable external {
        require(AUCTION_IN_SESSION[_tokenId] == false, "Auction: Auction is already in session");
        uint256 price = msg.value;
        _bid(_tokenId, price);
    }

    function currentBid(uint256 _tokenId) public view returns (uint256) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        return _highestBid[_tokenId];
    }

    function highestBidder(uint256 _tokenId) public view returns (address) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        return _highestBidder[_tokenId];
    }

    function startAuction(uint256 _tokenId) external nftOwner(_tokenId) {
        require(AUCTION_IN_SESSION[_tokenId] == false, "Auction: Auction is already in session");
        require(_highestBid[_tokenId] > 0, "Auction: Set a higher starting bid");
        AUCTION_IN_SESSION[_tokenId] = true;
        uint256 _startBid = _highestBid[_tokenId];

        // safeTransferFrom(_msgSender(), address(this), _tokenId, "send");
        approve(address(this), _tokenId);

        emit NewAuction(_tokenId, _msgSender(), _startBid);
    }

    function startAuctionWithReserve(uint256 _tokenId) external nftOwner(_tokenId) {
        require(AUCTION_IN_SESSION[_tokenId] == false, "Auction: Auction is already in session");
        require(_highestBid[_tokenId] > 0, "Auction: Set a higher starting bid");
        AUCTION_IN_SESSION[_tokenId] = true;
        WITH_RESERVE[_tokenId] = true;
        uint256 _startBid = _highestBid[_tokenId];

        emit NewAuction(_tokenId, _msgSender(), _startBid);
    }

    function auctionState(uint256 _tokenId) public view returns(bool) {
        return AUCTION_IN_SESSION[_tokenId];
    }

    function placeBid(uint256 _tokenId, uint256 _price) external {
        require(ownerOf(_tokenId) != _msgSender(), "Auction: NFT owner cannot bid");
        require(AUCTION_IN_SESSION[_tokenId] == true, "Auction: Auction is not in session");

        uint256 currentPrice = _price * (1 ether);

        require(currentPrice > currentBid(_tokenId), "Auction: New bid has to be more than previous bid");

        _bid(_tokenId, currentPrice);
    }

    function endAuction(uint256 _tokenId) external nftOwner(_tokenId) {
        require(AUCTION_IN_SESSION[_tokenId] == true, "Auction: Auction is not in session");

        AUCTION_IN_SESSION[_tokenId] = false;

        emit AuctionEnded(_tokenId, _msgSender(), currentBid(_tokenId));
    }

    function cancelAuction(uint256 _tokenId) external nftOwner(_tokenId) {
        require(AUCTION_IN_SESSION[_tokenId] == true, "Auction: Auction is not in session");
        require(WITH_RESERVE[_tokenId] == true, "Auction: Auction was not started with reserve");

        AUCTION_IN_SESSION[_tokenId] = false;
        WITH_RESERVE[_tokenId] = false;

        _highestBid[_tokenId] = 0;
        _highestBidder[_tokenId] = address(0);

        emit AuctionEnded(_tokenId, _msgSender(), currentBid(_tokenId));
    }

    function claimNFT(uint256 _tokenId) payable public returns(bool) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        require(_msgSender() == _highestBidder[_tokenId], "Auction: caller is not highest bidder");
        require(AUCTION_IN_SESSION[_tokenId] == false, "Auction: Auction is in session");

        uint256 _price = _highestBid[_tokenId];
        require(msg.value >= _price, "Auction: Not enough ether to claim token");

        _price = 0;

        address owner = ERC721.ownerOf(_tokenId);

        _highestBidder[_tokenId] = address(0);

        return true;
    }

}