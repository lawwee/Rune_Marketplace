const hre = require("hardhat");

const baseURI = "https://gateway.pinata.cloud/ipfs/QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/"

async function main() {
    const [owner, another, randomUser] = await hre.ethers.getSigners()
    const runeContractFactory = await hre.ethers.getContractFactory("RuneNFT")
    const runeContract = await runeContractFactory.deploy(baseURI)
    await runeContract.deployed()

    let txn = await runeContract.getPrice()
    console.log(txn)

    txn = await runeContract.name()
    console.log(txn)

    txn = await runeContract.symbol()
    console.log(txn)

    txn = await runeContract.connect(another).mintNFT("Odin", {value: hre.ethers.utils.parseEther("0.0001")})
    await txn.wait()

    txn = await runeContract.ownerOf(0)
    console.log(txn)

    txn = await runeContract.connect(another).approve(owner.address, 0)
    await txn.wait()
    console.log("approval successful")

    txn = await runeContract.connect(another).setApprovalForAll(owner.address, true)
    await txn.wait()
    console.log("total approval done")

    txn = await runeContract.isApprovedForAll(another.address, owner.address)
    console.log(txn)

    txn = await runeContract.getApproved(0)
    console.log(txn)

    txn = await runeContract.balanceOf(another.address)
    console.log(txn)
    
    txn = await runeContract.tokenURI(0)
    console.log(txn)

    txn = await runeContract.getMintedTokens()
    console.log(txn)

    txn = await runeContract.mintedSingleRune("Odin")
    console.log(txn)

    txn = await runeContract.transferFrom(another.address, randomUser.address, 0)
    await txn.wait()
    console.log("transfer successful")

    txn = await runeContract.ownerOf(0)
    console.log(txn)

}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})