const {
    networkConfig,
    developmentChains,
} = require("../helper-hardhard-config")
const { network } = require("hardhat")
const { verify } = require("../utils/verify")

module.exports = async (hre) => {
    const { getNamedAccounts, deployments } = hre
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // if chanId X use address Y
    let ethUsdPriceFeedAddress
    if (developmentChains.includes(network.name)) {
        const ethUsdAggregator = await deployments.get("MockV3Aggregator")
        ethUsdPriceFeedAddress = ethUsdAggregator.address
    } else {
        ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]
    }

    // if contact dosent exist we deploy a minimal version for local testing.
    const args = [ethUsdPriceFeedAddress]
    // when going for local host or hardhat we want to use a mock.
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: args, // price feed address
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    if (!developmentChains.includes(network.name) && process.env.ETHERSCAN) {
        await verify(fundMe.address, args)
    }
    log("______________________________________")
}
module.exports.tags = ["all", "fundme"]
