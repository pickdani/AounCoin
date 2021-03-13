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

    // events get logged, subscribe to events care about
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // Constructor
    // How many Aouncoin will ever exist
    // Set the total number of tokens
    // Read the total number of tokens
    uint256 public totalSupply;

    // key, value store
    // because these are public we get getter for free
    mapping(address => uint256) public balanceOf;
    // myaccount => (approvesthisaccount => tospendthesetokens)
    mapping(address => mapping(address => uint256)) public allowance;

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

    // approve, approve another account to send tokens (specific) on your behalf
    // the _spender is the account this wallet wants to approve to spend
    function approve(address _spender, uint256 _value) public returns (bool success) {
        // allowance, store it in this mapping
        allowance[msg.sender][_spender] = _value;

        // Approve event, msg.sender is the account that calls this function
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // transferFrom, someone else transfering on your behalf from approve
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // three acounts: one calling function, tranfer from, tranfser to
        // require _from has enough tokens
        require(_value <= balanceOf[_from]);

        // require the allowance is big enough
        require(_value <= allowance[_from][msg.sender]);
        
        // change balance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        // update the allowance
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }


}
