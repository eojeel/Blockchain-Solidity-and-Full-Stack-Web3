const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545");
    const wallet = new ethers.Wallet(
        "**WALLET PRIVATE KEY** ",
         provider
         );

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


    // manual trasnsaction RAW.
    // const nonce = await wallet.getTransactionCount();
    // const tx = {
    //     nonce: nonce,
    //     gasPrice: 20000000000,
    //     gasLimit: 1000000,
    //     to: null,
    //     value: 0,
    //     data: "0x .bin DATA"
    // }
    // const sendTxtResponse = await wallet.sendTransaction(tx);
    // await sendTxtResponse.wait(1);
    // console.log(sendTxtResponse);

}

main()
.then(() => process.exit(0))
.catch(error => {
    console.log(error);
    procexs.exit(1);
});
