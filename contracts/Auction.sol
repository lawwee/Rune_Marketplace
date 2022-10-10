// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

import "./RuneNFT.sol";
import "hardhat/console.sol";

contract Auction is RuneNFT {
    mapping(uint256 => uint256) private _highestBid;
    mapping(uint256 => address) private _highestBidder;
    mapping(uint256 => bool) private AUCTION_IN_SESSION;

    event NewAuction(uint256 indexed tokenId, address indexed seller);
    event AuctionEnded(uint256 indexed tokenId, address indexed seller);
    event AuctionCancelled(uint256 indexed tokenId, address indexed seller);
    event NewBid(uint256 indexed tokenId, uint256 indexed price, address indexed owner);

    constructor(string memory baseURI) RuneNFT(baseURI) {
        console.log("Auction Contract deployed");
    }

    modifier nftOwner(uint256 _tokenId) {
        require(_msgSender() == _ownerOf(_tokenId));
        _;
    }

    function _bid(uint256 _tokenId, uint256 _bidPrice) private {
        require(_bidPrice >= 0, "Auction: Bid price cannot be 0");
        uint256 price = _bidPrice * (1 ether);
        _highestBid[_tokenId] = price;
        _highestBidder[_tokenId] = _msgSender();
        emit NewBid(_tokenId, price, _msgSender());
    }

    function setStartBid(uint256 _tokenId, uint256 _bidPrice) nftOwner(_tokenId) public {
        require(AUCTION_IN_SESSION[_tokenId] == false, "Auction is already in session");
        _bid(_tokenId, _bidPrice);
    }

    function currentBid(uint256 _tokenId) public view returns (uint256) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        return _highestBid[_tokenId];
    }

    function highestBidder(uint256 _tokenId) public view returns (address) {
        require(_exists(_tokenId), "Auction: Token does not exist");
        return _highestBidder[_tokenId];
    }



//     AuctionStart(tokenid) / with reserve --> 
        // function to start contract for nft
        // must not be in session (AUCTION IN SESION)- use mapping
        // can only be called three days after auction has been ended(if ever called)
        // tokenid must exist
        // must have been minted
        // only be called by nft owner 

//     function startAuction(uint256 _tokenId) 
}

// Auction/Bidding Contract

// Variables and mapping and events
// highest bid price - map id to price
// highest bidder - map id to bidder
// Auction in session
// emit new bid
// emit start of auction
// emit end or cancellation of auction

// 1. AuctionStart(tokenid) / with reserve --> 
        // function to start contract for nft
        // must not be in session (AUCTION IN SESION)- use mapping
        // can only be called three days after auction has been ended(if ever called)
        // tokenid must exist
        // must have been minted
        // only be called by nft owner 
// 2. AuctionEnd(tokenid) -->
        // tokenid must exist
        // must be in session
        // to end auction for nft
        // must have started
        // only be called by nft owner
// 3. SetStartingPrice(price and tokenid) -->
        // Must be set before auction starts
        // only called by nft owner
// 4. AuctionCancelled/Unlist(tokenid) -->
        // called by owner
        // Has to be in session
        // tokenid must exist
        // sets highest bidding to 0
        // ends auction
// 5. Placebid(bid price and tokenid) --> 
        // tokenid exists
        // function can only execute when auction starts
        // cant be executed when auction ends or is cancelled
        // nft owner cannot place bid
        // price has to be more than normal price / highest bidding price
        // price replaces current highestbidding price
        // price before auction starts is set as highestbid
// 6. CurrentBidPrice()        
// 7. ClaimNFT() -->
        // tokenid must exist
        // caller must be who owns highest bid
        // must have enough balance as highest bid to claim NFT
        // resets highest bid to 0
        // resets highest bidder to a zero address
        // transfers nft ownership to highest bidder
// 8. GetHighestBidder()
