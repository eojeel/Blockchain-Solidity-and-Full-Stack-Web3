// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

        function getPrice() internal view returns (uint256) {
        // interacting with a contract outside our scope. req (ABI / ADDR)
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // ETH in terms of USD.
        return uint256(price * 1e10);
        // 1**10 = 10000000000
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {

        uint256 ethPrice = getPrice();
        // 3000.000000000000000000 = ETH / USD price
        // 1_000000000 ETH

        uint256 ethAmountinUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountinUsd;

    }

}

// etherscan ringby 0xbDd0D4F161E8388d9B9d31181fc4c229A116F59a