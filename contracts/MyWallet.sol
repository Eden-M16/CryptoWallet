// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MyWallet {
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    receive() external payable {}
    
    function sendMoney(address payable to, uint256 amount) public {
        require(msg.sender == owner, "Not owner!");
        require(address(this).balance >= amount, "Not enough funds!");
        
        // NEW: Use call instead of transfer
        (bool success, ) = to.call{value: amount}("");
        require(success, "Transfer failed!");
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}