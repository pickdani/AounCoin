pragma solidity >=0.4.2;

// Aouncoin.sol:
// implement the ERC 20 standard, govern the behavior of the token

contract Aouncoin {

     string public name     = "Aouncoin";
     string public symbol   = "AOUN";
     string public standard = "Aouncoin v1.0";


    // Constructor
    // How many Aouncoin will ever exist
    // Set the total number of tokens
    // Read the total number of tokens
    uint256 public totalSupply;

    // key, value store
    mapping(address => uint256) public balanceOf;

    // solidity convention local var start with _
    constructor(uint256 _initialSupply) public {

        // msg is a global var in solidity, sender is address that called this function
        // key value of balance, account that deploys contract
        balanceOf[msg.sender] = _initialSupply;
        
        totalSupply = _initialSupply;
        // allocate the initial supply
    }

    // this contract is responsible for knowing where the tokens are
    // everytime bough sold or transfer, contract must know who has each token
}

