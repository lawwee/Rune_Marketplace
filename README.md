# RUNE MARKETPLACE 

**Technologies Used**
* Solidity
* Javascript
* Hardhat
* Remix IDE
* Alchemy
* Metamask

Rune Marketplace is an NFT Based project, that allows users to mint already made NFTs at a particular price, while also allowing a selling option in form of an auction.

The Contract address is **0x5D991817136F19eAFa2925Da189642d309b9888f** which can be found on the Polygon_Mumbai Testnet of the Polygon network.

The main purpose of the project is to allow users be able to own NFTs that have been created, each having a naming convention derived from that of the Greek gods such as Odin and Thor. Additionally, it allows users who have already bought an NFT to sell it to other users in form of an auction, where the highest bidder is able to buy it off.

Here are the functions available in the project. Since there are over 10 smart contract, all created to make this project successful, the functions have been splitted into various sections for better understanding;

**ERC721**

This section has to do with all the functionaities as required to fulfill the rules of an ERC721 TokenStandard.

* The Transfer Event - is triggered when a transfer of tokens happens between addresses. It takes three parameters namely from, to and tokenId. The "from" refers to the account from which the token is being transferred, the "to" refers to address that receives the tokens. The "tokenId" refers to the token being transferred.

* The Approval Event - It takes three parameters namely owner, approved and tokenId. The "owner" refers to the address that wishes to approve a token to another address, the "approved" refers to the address that receives the approval of said token. The "tokenId" refers to the token being set for approval.

* The ApprovalForAll Event - This event also takes three parameters namely owner, operator and approved. it gets triggered when the "owner" approves the "operator" to manage all the tokens in "owner's" wallet address. The "approved" parameter is a boolean value that changes in regrad to the current state of the event.

* The balanceOf() Function - it returns the token balance of an address. It takes in one parameter named address, which repreesents the address of which the request is meant upon.

* The ownerOf() Function - takes in a parameter in the name of tokenId, and returns the address that owns the requested Id.

* The transferFrom() Function - it takes three parameters namely from, to and tokenId. "from" is the address where the is being sent from, "to" is the address where the token is being sent to, and "tokenId" is the token being sent. This function allows whoever calls it be able to send tokens from another address (from) to another address (to). This transaction can only succeed if the caller has been approved beforehand using the approve() function, together with the limit of the allowed tokens.

* The safeTransferFrom() Function - This function performs the same thing as the transferFrom() function, but it takes an extra parameter which is "data" and can be referred to as an optional description sent with each transfer. The function also implements the IERC721Received protocol, allowing smart contracts to also be able to buy and sell the NFTs.

* The approve() Function - the function takes in two parameters namely to and tokenId. The "amount" refers to the token about to br approved. The function allows whoever calls it to approve the management of a token to another wallet address.

* The setApprovalForAll() Function - it takes in two parameters namely operator and approved. It gives management access of all the caller's tokens to another address "operator", while the "approved" parameter changes based on the current state of the function.

* The getApproved() Function - This aims to check which address has access to manage a token besides its owner. It takes in one parameter which is "tokenId", and returns the "operator" address that has access to it.

* The isApprovedForAll() Function - takes teo parameters namely owner and operator. It checks to see if the address "owner" has approved the "operator" to manage the tokens in "owner's" address, and then returns a boolean value based on the state.

* The tokenURI() Function - this takes in one parameter which represents the "tokenId" and returns the URI link to the metadata of said tokenId.


**RuneNFT**

This section basically contains the functionalities related to the main marketplace that allows users to buy and claim their NFTs

* The NewNFTMinted Event - it gets triggered when a new NFT has been minted and emits two details namely buyer and tokenId. "buyer" being the person who minted a new one and "tokenId" being the ID assigned to the newly minted NFT.

* The getPrice() Function - it takes no parameters and simply returns the general price of the NFTs.

* The getMintedTokens() Function - also takes no parameter and returns the tokenIds that have already been minted.

* The mintNFT() Function - it allows users mint a new NFT into their wallet address. It takes in one parameter which is the name of the NFT they would like to buy, it also checks if the amount of money sent is not enough, and rejects it accordingly.


**Auction**

This section contains all the functionalities needed for the auction to work as it should.

* The NewAuction Event - takes in three parameters namely tokenId, seller and startBid. The "tokenId" is the token being put up for auction, the "seller" is the address/person that chooses to auction, and the "startBid" is basically the starting bid of the auction;.

* The AuctionEnded Event - gets emitted when an auction session has ended. It takes in three parameters namely tokenId, seller and finalBid. "tokenId" refers to the token that was auctioned, "seller" refers to who held the auction and "finalBid" refers to the highest bid at the end of the auction.

* The AuctionCancelled Event - This is triggered when an auction is cancelled mid way. It only takes two parameters namely tokenId and seller. "tokenId" refers to the token that was originally on sale, and "seller" refers to who was selling the token.

* The NewBid Event - this gets emitted when a new bid has been placed upon a token in an auction sale. It takes three parameters namely tokenId {see NewAuction}, price and owner. The "price" refers to the bid that was placed and the "owner" refers to who started the auction.

* The setStartBid() Function - this is used when the owner of a tken is about to start an auction, it sets the starting bid of the token and requires that the auction is not already started before starting. It takes only the "tokenId" parameter and can only be called by the owner if the said token

* The currentBid() Function - it takes the "tokenId" parameter and checks for the current highest bid of the said token. 

* The highestBidder() Function - this also takes the "tokenId" parameter and returns the current highest bidder of the token.

* The startAuction() Function - it takes in the "tokenId" parameter and is called when an auction wants to start. It requires that only the token owner can call it and that the auction has not started before hand.

* The startAuctionWithReserve() Function - This serves the same purpose as the startAuction() function but with an extra functionality that allows whoever created the auction to cancel and not proceed with the auction anymore.

* The auctionState() Function - takes in the "tokenId" parameter and checks the current state of the auction.

* The placeBid() Function - the function takes in the "tokenId" parameter and allows users to place a bid on the auction. It requires that the auction must be in session and the new bid must be more than the previous bid.

* The endAuction() Function - this ends the ongoing auction of a token, and automatically transfer the token to the highest bidder. It requires the auction must be in session and that only the original owner of the token can call the function.

* The cancelAuction() Function - although similar to the endAuction() function, this is called when the owner chooses to cancel the auction entirely and not sell anymore. It requires the auction must be in session and must have been initiated with the startAuctionWithReserve() function.

* The withdrawReserve() Function - takes in the "tokenId" parameter and allows previous bidders to withdraw their bids.
