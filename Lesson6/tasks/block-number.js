const { task } = require("hardhat/config");

task("block-number", "Prints current block number").setAction(
    // Anon function
    async (taskArgs, hre) => {
        const blockNumber = await hre.ethers.provider.getBlockNumber();
        console.log("Current Block Number: "+blockNumber);
    }
    // const blockTask = async function() => {}
    // async function blocktask() {}
);

module.exports = {}
