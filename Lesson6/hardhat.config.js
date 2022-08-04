require("@nomicfoundation/hardhat-toolbox")
require("@nomiclabs/hardhat-etherscan")
require("./tasks/block-number")
require("hardhat-gas-reporter")
require("solidity-coverage")
require("dotenv").config()

const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL
const PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;

const GORELI_PRIVATE_KEY = process.env.GORELI_PRIVATE_KEY;
const GORELI_RPC_URL = process.env.GORELI_RPC_URL;

const ETHERSCAN = process.env.ETHERSCAN;
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    networks: {
        rinkeby: {
            url: RINKEBY_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 4,
        },
        goerli: {
            url: GORELI_RPC_URL,
            accounts: [GORELI_PRIVATE_KEY],
            chainId: 5,
        },
        localhost: {
            url: "http://127.0.0.1:8545/",
            chainId: 31337
        }
    },
defaultNetwork: "hardhat",
  solidity: "0.8.15",
  etherscan: {
    api:ETHERSCAN
  },
  gasReporter: {
    enabled: true,
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: COINMARKETCAP_API_KEY,
    token: "ETH"
  }
};
