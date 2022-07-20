/*
    Get Funds from users. 
    Withdraw funds
    Set a minim funding value in GBP.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public MinimumUSD = 50 * 1e18; // 1 * 1 ** 18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded; 
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
        
        // require means it happens or fails.
        require(getConversionRate(msg.value) > MinimumUSD, "Didnt Send Enought!"); // 1e18 = 1 X 10 ** 18 === 1000000000000000000
        //msg is global var.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function getPrice() public view returns (uint256) {
        // interacting with a contract outside our scope. req (ABI / ADDR)
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // ETH in terms of USD.
        return uint256(price * 1e10);
        // 1**10 = 10000000000
    }

    function getVErsion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {

        uint256 ethPrice = getPrice();
        // 3000.000000000000000000 = ETH / USD price
        // 1_000000000 ETH

        uint256 ethAmountinUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountinUsd;

    }

}

