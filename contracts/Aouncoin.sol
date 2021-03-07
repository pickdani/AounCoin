pragma solidity ^0.4.2;

// Aouncoin.sol:
// implement the ERC 20 standard, govern the behavior of the token

contract Aouncoin {
    
    // Constructor
    // How many Aouncoin will ever exist
    // Set the total number of tokens
    // Read the total number of tokens
    uint256 public totalSupply;

    function Aouncoin () public {
        
        totalSupply = 1000000; // 1MM total supply (ever)
    
    }

}

