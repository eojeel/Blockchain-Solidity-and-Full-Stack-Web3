const { ethers } = require("hardhat");

async function main() {
    const simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
    console.log("Depoying Contact..");
    const simpleStorage = await simpleStorageFactory.deploy();
    await simpleStorage.deployed();

    console.log("Deployed Contract to"+simpleStorage.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
