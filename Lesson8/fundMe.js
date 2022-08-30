// imports
import { ethers } from "/ethers-5.2.esm.min.js"
import { abi, contractAddress } from "/constants.js"

const connectButton = document.getElementById("connectButton")
connectButton.onclick = connect

const fundButton = document.getElementById("fundButton")
fundButton.onclick = fund

const balanceButton = document.getElementById("getBalance")
balanceButton.onclick = getBalance

const withdrawButton = document.getElementById("withdrawButton")
withdrawButton.onclick = withdraw

async function connect() {
    if (typeof window.ethereum !== "undefined") {
        try {
            await window.ethereum.request({ method: "eth_requestAccounts" })
        } catch (error) {
            console.log(error)
        }
        connectButton.innerHTML = "Connected"
        await window.ethereum.request({ method: "eth_accounts" })
    } else {
        connectButton.innerHTML = "Please Install Metamask!"
        console.log("No Metamask!")
    }
}

// fund function
async function fund() {
    const ethAmount = document.getElementById("ethAmount").value
    console.log(`Funding with ${ethAmount}...`)
    if (typeof window.ethereum !== "undefined") {
        // privder / connection to the blockchain
        // signer / wallet / someonewith gas
        // contract that we are using ABI & Address
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const signer = provider.getSigner()
        const contract = new ethers.Contract(contractAddress, abi, signer)

        try {
            const transactionResponse = await contract.fund({
                value: ethers.utils.parseEther(ethAmount),
            })
            // listen for the tx to be mined
            await listenForTxMine(transactionResponse, provider)
            console.log(`Done!`)
        } catch (error) {
            console.log(error)
        }
    }
}

function listenForTxMine(transactionResponse, provider) {
    console.log(`Mining ${transactionResponse.hash}...`)
    // listen to transaction to finish
    return new Promise((resolve, reject) => {
        provider.once(transactionResponse.hash, (transactionReciept) => {
            console.log(
                `Completed with ${transactionReciept.confirmations} confirmations`
            )
            resolve()
        })
    })
}

async function getBalance() {
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const balance = await provider.getBalance(contractAddress)
        console.log(ethers.utils.formatEther(balance))
    }
}

// withdraw
async function withdraw() {
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const signer = provider.getSigner()
        const contract = new ethers.Contract(contractAddress, abi, signer)
        try {
            const transactionResponse = await contract.withdraw()
            await listenForTxMine(transactionResponse, provider)
        } catch (error) {
            console.log(error)
        }
    }
}
