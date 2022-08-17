// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Imports
import "./PriceConverter.sol";

// 3. Interfaces, Libraries, Contracts
error FundMe__NotOwner();

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
    address[] private s_funders;
    mapping(address => uint256) private s_addressToAmountFunded;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    // Modifiers
    modifier onlyOwner() {
        // require(msg.sender == i_owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
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
        require(msg.value.getConversionRate(s_priceFeed) > MINIMUM_USD, "Didnt Send Enought!");
        // 1e18 = 1 X 10 ** 18 === 1000000000000000000
        //msg is global var.
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public payable onlyOwner {

        for(uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++)
        {
            s_addressToAmountFunded[s_funders[funderIndex]] = 0;
        }

        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    function cheaperWithdraw() public payable onlyOwner {

        address[] memory funders = s_funders;
        // mappings cant be in memory.

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);

       (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    function getOwner() public view returns(address)
    {
        return i_owner;
    }

    function getFunder(uint256 index) public view returns(address)
    {
        return s_funders[index];
    }

    function getAddressToAmountFunded(address funder) public view returns(uint256)
    {
    return s_addressToAmountFunded[funder];
    }

    function getPriceFeed() public view returns(AggregatorV3Interface)
    {
        return s_priceFeed;
    }
}
