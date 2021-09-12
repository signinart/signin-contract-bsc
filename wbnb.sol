/**
 *Submitted for verification at BscScan.com on 2021-06-25
*/

pragma solidity >=0.6.0 <0.9.0;

contract WBSC { 
    string public name = "SignIn SWAP BNB Token";
    string  public symbol = "WBNB";
    uint256 public totalSupply_ = 0;
    uint8   public decimals = 18;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    constructor() public {
    }

    receive() external payable {
        require(msg.value > 0);
        totalSupply_ = totalSupply_ + msg.value;
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    fallback() external {}

    function swapToken(address _to) public payable returns (bool success) {
        require(msg.value > 0);
        totalSupply_ = totalSupply_ + msg.value;
        balances[_to] = balances[_to] + msg.value;
        return true;
    }

    function withdraw(uint256 _value,address _to) public payable returns (bool success){
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = balances[msg.sender] - _value;
        totalSupply_ = totalSupply_ - _value;
        address payable to = payable(address(_to));
        to.send(_value);
        return true;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] =  balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value; 
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value; 
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
