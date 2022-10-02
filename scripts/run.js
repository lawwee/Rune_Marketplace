const hre = require("hardhat");

async function main() {
    const runeContractFactory = await hre.ethers.getContractFactory("RuneNFT")
    const runeContract = await runeContractFactory.deploy("ipfs://QmcwdWvZB6nqoCFDw4CKU2vZYC5oHJPtAr6ehCV2EMBTkW/")
    await runeContract.deployed()

}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})