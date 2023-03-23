//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArbitragePredictor {
    // Structure to store exchange data
    struct Exchange {
        string name;
        uint256 tokenAPrice;
        uint256 tokenBPrice;
    }

    Exchange[] public exchanges;

    // Add a new exchange with token prices
    function addExchange(
        string memory _name,
        uint256 _tokenAPrice,
        uint256 _tokenBPrice
    ) public {
        exchanges.push(Exchange(_name, _tokenAPrice, _tokenBPrice));
    }

    // Calculate and return the most profitable exchange for arbitrage
    function getBestArbitrageExchange() public view returns (string memory) {
        require(exchanges.length > 1, "Not enough exchanges to compare.");

        uint256 maxProfit = 0;
        uint256 profit;
        uint256 index;

        // Loop through all exchange pairs to find the best arbitrage opportunity
        for (uint256 i = 0; i < exchanges.length - 1; i++) {
            for (uint256 j = i + 1; j < exchanges.length; j++) {
                // Calculate potential profit from buying Token A on exchange i and selling on exchange j
                profit = exchanges[j].tokenAPrice * 1 ether / exchanges[i].tokenAPrice - 1 ether;
                if (profit > maxProfit) {
                    maxProfit = profit;
                    index = j;
                }

                // Calculate potential profit from buying Token B on exchange i and selling on exchange j
                profit = exchanges[j].tokenBPrice * 1 ether / exchanges[i].tokenBPrice - 1 ether;
                if (profit > maxProfit) {
                    maxProfit = profit;
                    index = j;
                }
            }
        }

        return exchanges[index].name;
    }
}
