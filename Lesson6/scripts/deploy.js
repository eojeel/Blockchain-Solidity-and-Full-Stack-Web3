const { ethers, run, network } = require("hardhat");

async function main() {
    const simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
    console.log("Depoying Contact..");
    const simpleStorage = await simpleStorageFactory.deploy();
    await simpleStorage.deployed();

    console.log("Deployed Contract to: "+simpleStorage.address);
    console.log(network.config);
    if(network.config.chainId == 5 && process.env.ETHERSCAN)
    {
        await simpleStorage.deployTransaction.wait(6);
        await verify(simpleStorage.address, []);
    }

    const currentValue = await simpleStorage.retrieve();
    console.log("Current value is: "+currentValue);

    // update current value
    const transactionResponse = await simpleStorage.store(7);
    await transactionResponse.wait(1);
    const updatedValue = await simpleStorage.retrieve();
    console.log("Updated Value:"+updatedValue);
}

async function verify(contractAddress, args) {
    console.log('Verifing Contract...');
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        });
    }
    catch (e) {
        if(e.message.toLowerCase().includes("already verified")) {
            console.log('Already Verified');
        } else {
            console.log(e);
        }
    }
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
