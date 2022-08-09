const { network } = require("hardhat")
const {
    developmentChains,
    DECIMALS,
    INITAL_ANSWER,
} = require("../helper-hardhard-config")

module.exports = async (hre) => {
    const { getNamedAccounts, deployments } = hre
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    if (developmentChains.includes(network.name)) {
        log("Local Network Detected Deploying Mocks")
        await deploy("MockV3Aggregator", {
            contract: "MockV3Aggregator",
            from: deployer,
            log: true,
            args: [DECIMALS, INITAL_ANSWER],
        })
        log("Mocks Deployed")
        log("_____________________________")
    }
}

module.exports.tags = ["all", "mocks"]
