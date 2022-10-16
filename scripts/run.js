const { ethers } = require("hardhat");
const hre = require("hardhat");

const baseURI = "https://gateway.pinata.cloud/ipfs/QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/"

async function main() {
    const [owner, another, randomUser] = await hre.ethers.getSigners()
    const runeContractFactory = await hre.ethers.getContractFactory("Auction")
    const runeContract = await runeContractFactory.deploy(baseURI)
    await runeContract.deployed()

    let balance = await hre.ethers.provider.getBalance(runeContract.address);
    console.log("Another Balance", hre.ethers.utils.formatEther(balance));

    txn = await runeContract.connect(another).mintNFT("Odin", {value: hre.ethers.utils.parseEther("0.0001")})
    await txn.wait()

    txn = await runeContract.connect(another).setStartBid(0, 2)
    await txn.wait()
    console.log("success")

    // txn = await runeContract.connect(another).startAuctionWithReserve(0)
    // await txn.wait()
    // console.log("Auction with res success")

    txn = await runeContract.connect(another).startAuction(0)
    await txn.wait()
    console.log("Auction start")

    txn = await runeContract.currentBid(0)
    console.log("Current bid:", hre.ethers.utils.formatEther(txn))

    txn = await runeContract.placeBid(0, 3)
    await txn.wait()
    console.log("Bid success");

    txn = await runeContract.currentBid(0)
    console.log("Current bid:", hre.ethers.utils.formatEther(txn))

    txn = await runeContract.endAuction(0)
    await txn.wait()
    console.log("Auction Ended");

}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})