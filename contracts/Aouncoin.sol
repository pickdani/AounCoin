pragma solidity >=0.4.2;

// Aouncoin.sol:
// implement the ERC 20 standard, govern the behavior of the token

contract Aouncoin {

     string public name     = "Aouncoin";
     string public symbol   = "AOUN";
     string public standard = "Aouncoin v1.0";

     // transfer event complying with erc20 event
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

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
    }

    // Transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Exception if sender balance too low
        // Return a boolean
        // Transfer event

        // must have enough coins to send
        require(balanceOf[msg.sender] >= _value);

        // le transaction
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Transfer event
        // MUST fire the Transfer even by ERC20 Docs
        emit Transfer(msg.sender, _to, _value);

        // only if all above is executed successfully
        return true;
    }
}

