const hre = require("hardhat");

const baseURI = "https://gateway.pinata.cloud/ipfs/QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/"


async function main() {
  const auctionContractFactory = await hre.ethers.getContractFactory("Auction");
  const auctionContract = await auctionContractFactory.deploy(baseURI);
  await auctionContract.deployed()

  console.log("Contract address is: ", auctionContract.address)
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
