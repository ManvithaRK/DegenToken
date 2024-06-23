# DegenToken

## Overview

DegenToken is an ERC20 token deployed on the Avalanche Fuji testnet. It provides users with functionalities to mint, burn, transfer, and redeem tokens. The primary use case of DegenToken is to facilitate a ticketing system where users can exchange tokens for concert tickets. The project leverages OpenZeppelin libraries for secure and standard-compliant token implementation.
## Description

DegenToken is an ERC20 token deployed on the Avalanche Fuji testnet. The token allows users to mint, burn, transfer, and redeem tokens for concert tickets. The project uses OpenZeppelin libraries to ensure security and standard compliance. It includes a basic ticketing system where users can redeem their tokens for specific concert tickets.

## Getting Started

### Installing

 1. Clone the repository from GitHub: git clone https://github.com/your-repo/degen-token.git
 2. Navigate to the project directory: cd degen-token
 3. Install the required dependencies:npm install
 4. Create a .env file in the project root and add your private key and Snowtrace API key:PRIVATE_KEY=your_private_key
SNOWTRACE_API_KEY=your_snowtrace_api_key

### Executing program

1. Complie the smart contract: npx hardhat compile
2. Deploy the smart contract to the Avalanche Fuji testnet: npx hardhat run scripts/deploy.js --network fuji
3. Verify the deployed contract on Snowtrace: npx hardhat verify [deployed_contract_address] --network fuji

### The Program
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    mapping(address => string) public ticket_redeemed;
    mapping(uint => uint) public tickets;
    mapping(uint => uint) public price;
    string[] public concert_ticket_store;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        concert_ticket_store = ["Available show tickets:", "Weeknd concert general ticket", "Justin Bieber concert general ticket", "Kanye West VIP ticket"];
        tickets[1] = 10;
        tickets[2] = 8;
        tickets[3] = 4;
        price[1] = 250;
        price[2] = 300;
        price[3] = 1000;
    }

    function mint(address mint_address, uint256 value) public onlyOwner {
        _mint(mint_address, value);
    }

    function burn(uint256 value) public override {
        _burn(msg.sender, value);
    }

    function transfer(address recipient, uint256 value) public override returns (bool) {
        _transfer(msg.sender, recipient, value);
        return true;
    }

    function redeem(uint256 show_id, uint256 quantity) public {
        require(show_id > 0 && show_id < 4, "Invalid choice");
        assert(quantity < tickets[show_id]);
        require(balanceOf(msg.sender) >= quantity * price[show_id], "Insufficient Tokens");
        _burn(msg.sender, quantity * price[show_id]);
        tickets[show_id] -= quantity;
        ticket_redeemed[msg.sender] = concert_ticket_store[show_id];
    }
}
```
## Help

For any common problems or issues, you can check the Hardhat documentation or use the following command to get more information about available tasks:
npx hardhat help

## Authors

Manvitha R Kabbathi

[manvitha.r.kabbathi@gmail.com]


## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
