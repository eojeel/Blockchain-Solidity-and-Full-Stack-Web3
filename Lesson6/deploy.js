const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function main() {
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    const encryptedJson = fs.readFileSync("./.encryptedKey.json", "utf-8");
    let wallet = new ethers.Wallet.fromEncryptedJsonSync(
        encryptedJson,
        process.env.PRIVATE_KEY_PASS
    );

    wallet = await wallet.connect(provider);

    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf-8");
    const bin = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf-8");
    const contractFactory = new ethers.ContractFactory(abi, bin, wallet);
    console.log("deploying Please Wait");
    const contract = await contractFactory.deploy();
    const deploymentReciept = await contract.deployTransaction.wait(1);

    console.log("here is the deployment transaction");
    console.log(contract.deployTransaction);
    console.log("here is the transaction reciept");
    console.log(deploymentReciept);

    // Retrieve Fav number from SimpleStorage.sol function
    const currentFavoriteNumber = await contract.retrieve();
    console.log("Current Favorite Number: " + currentFavoriteNumber.toString());

    // Update Fav number from SimpleStorage.sol function
    const transactionResponse = await contract.store("7");
    const transactionRecipet = await transactionResponse.wait(1);
    const updatedFavoriteNumber = await contract.retrieve()
    console.log("Updated Favorite Number: " + updatedFavoriteNumber);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.log(error);
        process.exit(1);
    });
