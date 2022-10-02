const hre = require("hardhat");

const baseURI = "https://gateway.pinata.cloud/ipfs/QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/"

async function main() {
    const [owner, another] = await hre.ethers.getSigners()
    const runeContractFactory = await hre.ethers.getContractFactory("RuneNFT")
    const runeContract = await runeContractFactory.deploy(baseURI)
    await runeContract.deployed()

    let txn = await runeContract.getPrice()
    console.log(txn)

    txn = await runeContract.connect(another).mintNFT("Odin", {value: hre.ethers.utils.parseEther("0.0001")})
    await txn.wait()
    
    txn = await runeContract.tokenURI(0)
    console.log(txn)

    txn = await runeContract.getMintedTokens()
    console.log(txn)

    txn = await runeContract.mintedSingleRune("Odin")
    console.log(txn)

}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})