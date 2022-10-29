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
