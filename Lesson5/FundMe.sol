/*
    Get Funds from users.
    Withdraw funds
    Set a minim funding value in GBP.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    // constant & immutable better gas usage.
    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 1 ** 18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;
    // 23644 - non immutble
    // 21508 - immutable

    constructor() {
        i_owner = msg.sender;
    }
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
        require(msg.value.getConversionRate() > MINIMUM_USD, "Didnt Send Enought!"); // 1e18 = 1 X 10 ** 18 === 1000000000000000000
        //msg is global var.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner{

        //require(msg.sender == owner, "You are not the owner!");

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            addressToAmountFunded[funders[funderIndex]] = 0;
        }
        // empty array no objects
        funders = new address[](0);

/*
        //transfer (auto reverts if fails)
        payable(msg.sender).transfer(address(this).balance);

        //send (fails if handled)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");
*/
        //call (returns two vars)
        // bytes memory dataReturned
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner {
        //require(msg.sender == i_owner, "You are not the owner!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
