// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Imports
import "./PriceConverter.sol";

// Error Codes
error fundMe__NotOwner();

// Interface, Libarys, Contracts

/** @title A contract for crow funding
 *  @author Joe Lee
 *  @notice This contract is to demo a sample funding contract
 *  @dev this implements price feeds as our libary
 */
contract FundMe {
    // type Declarations
    using PriceConverter for uint256;

    // State Varables
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address public immutable i_owner;
    AggregatorV3Interface public priceFeed;

    // Modifier
    modifier onlyOwner {
        if(msg.sender != i_owner) { revert fundMe__NotOwner(); }
        _;
    }

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    /**
     *  @notice This function funds the contract
     *  @dev this implements price feeds as our libary
     */
    function fund() public payable {

        // require means it happens or fails.
        require(msg.value.getConversionRate(priceFeed) > MINIMUM_USD, "Didnt Send Enought!"); // 1e18 = 1 X 10 ** 18 === 1000000000000000000
        //msg is global var.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            addressToAmountFunded[funders[funderIndex]] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }
}
