// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    mapping(address => string) public ticket_redeemed;
    mapping(uint=>uint)public tickets;
    mapping(uint=>uint)public price;
    string[] public concert_ticket_store;
    
    

    constructor() ERC20("Degen", "DGN")Ownable(msg.sender) {
        concert_ticket_store = ["Available show tickets:", " Weeknd concert general ticket", " Justin Bieber concert general ticket"," Kanye West VIP ticket"];
        tickets[1]=10;
        tickets[2]=8;
        tickets[3]=4;
        price[1]=250;
        price[2]=300;
        price[3]=1000;
        
    }

    function mint(address mint_address, uint256 value) public onlyOwner {
        _mint(mint_address, value);
    }

    function burn(uint256 value) public override  {
        _burn(msg.sender, value);
    }

    function transfer(address recipient, uint256 value) public override returns (bool) {
        _transfer(msg.sender, recipient, value);
        return true;
    }

    function redeem(uint256 show_id,uint256 quantity) public {
        require(show_id > 0 && show_id < 4 , "Invalid choice");
        assert(quantity<tickets[show_id]);
        require(balanceOf(msg.sender)>=quantity*price[show_id],"Insufficient Tokens");
        _burn(msg.sender, quantity*price[show_id]);
        tickets[show_id]-=quantity;
        ticket_redeemed[msg.sender]=concert_ticket_store[show_id];
        
    }   
}
