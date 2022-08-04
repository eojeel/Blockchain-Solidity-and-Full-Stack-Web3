    // manual trasnsaction RAW.
     const nonce = await wallet.getTransactionCount();
     const tx = {
            nonce: nonce,
         gasPrice: 20000000000,
         gasLimit: 1000000,
         to: null,
         value: 0,
         data: "0x .bin DATA"
     }
     const sendTxtResponse = await wallet.sendTransaction(tx);
     await sendTxtResponse.wait(1);
     console.log(sendTxtResponse);
