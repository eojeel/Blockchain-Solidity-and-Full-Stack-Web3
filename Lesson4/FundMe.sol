/*
    Get Funds from users. 
    Withdraw funds
    Set a minim funding value in GBP.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {

    uint256 public MinimumGBP = 10;
    /*
     set min amount in GBP
     1. how do we send ETH to this contact.
    
    Every transaction has the following
    - Nonce: tx count for the amount
    - Gas Price: price per unit of was (wei)
    - Gas Limit 21000
    - To: address that the TX is sent to. 
    - Value: Amount of wei
    - Data: Empty
    - v,r,s, components of tx signature.
    */
    function fund() public payable {
        
        require(msg.value > MinimumGBP, "Didnt Send Enought!"); // 1e18 = 1 X 10 ** 18 === 1000000000000000000

    }
    
    /*
    function withdraw() {

    }
    */
}

