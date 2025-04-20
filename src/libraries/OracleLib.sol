// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title Oracle Library
 * @author Youssef following pat collins
 * @notice this library is used to check the chainlink Oracle for stale data
 * If a price is stale, the function will revert, and render DSCEngine unusable
 * We want DSCEngine to be unusable if the price is stale
 *
 * so if the chainlink network explodes and you have a lot of money locked in the protocol...
 *
 */
library OracleLib {
    error OracleLib__StalePrice();

    uint256 private constant TIMEOUT = 3 hours;

    function staleCheckLatestRoundData(AggregatorV3Interface priceFeed)
        public
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        (uint80 roundID, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.latestRoundData();
        require(price > 0, "OracleLib: stale price");

        uint256 secondSince = block.timestamp - updatedAt;

        if (secondSince > TIMEOUT) {
            revert OracleLib__StalePrice();
        }
        return (roundID, price, startedAt, updatedAt, answeredInRound);
    }
}
