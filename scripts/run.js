const hre = require("hardhat");

const baseURI = "https://gateway.pinata.cloud/ipfs/QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/"

async function main() {
    // const [owner, another, randomUser] = await hre.ethers.getSigners()
    const runeContractFactory = await hre.ethers.getContractFactory("Auction")
    const runeContract = await runeContractFactory.deploy(baseURI)
    await runeContract.deployed()

    txn = await runeContract.mintNFT("Odin", {value: hre.ethers.utils.parseEther("0.0001")})
    await txn.wait()

    txn = await runeContract.ownerOf(0)
    console.log(txn)

    txn = await runeContract.currentBid(0)
    console.log(txn)

    txn = await runeContract.highestBidder(0)
    console.log(txn)

    txn = await runeContract.setStartBid(0, 2)
    await txn.wait()
    console.log("Set success")

    txn = await runeContract.currentBid(0)
    console.log(txn)

    txn = await runeContract.highestBidder(0)
    console.log(txn)
}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})