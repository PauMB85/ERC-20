// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./IMyTokenERC20.sol";

contract MyTokenERC20 is IMyTokenERC20 {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    uint256 private totalSupplyToken;
    string private nameToken;
    string private symbolToken;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        nameToken = _name;
        symbolToken = _symbol;
        totalSupplyToken = _totalSupply;
    }

    // funciones
    function name() public view override returns (string memory) {
        return nameToken;
    }

    function symbol() public view override returns (string memory) {
        return symbolToken;
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function totalSupply() public view override returns (uint256) {
        return totalSupplyToken;
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        return balances[_owner];
    }

    function allowance(
        address _owner,
        address _spender
    ) public view override returns (uint256) {
        return allowances[_owner][_spender];
    }

    function approve(
        address _spender,
        uint256 _value
    ) public override returns (bool) {
        address owner = msg.sender;
        _approve(owner, _spender, _value);
        return true;
    }

    function transfer(
        address _to,
        uint256 _value
    ) public override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool) {
        address spender = msg.sender;
        _spenderAllowance(_from, spender, 0);
        _transfer(_from, _to, _value);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_from != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = balances[_from];

        require(
            fromBalance >= _value,
            "ERC20: transfer amount exceeds balance"
        );

        unchecked {
            balances[_from] = fromBalance - _value;
        }

        balances[_to] += _value;

        emit Transfer(_from, _to, _value);
    }

    function _approve(
        address _owner,
        address _spender,
        uint256 _value
    ) internal {
        require(_owner != address(0), "ERC20: transfer owner the zero address");
        require(
            _spender != address(0),
            "ERC20: transfer spender the zero address"
        );

        allowances[_owner][_spender] = _value;

        emit Approval(_owner, _spender, _value);
    }

    function _spenderAllowance(
        address _owner,
        address _spender,
        uint256 _value
    ) internal {
        uint256 currentAllowance = allowance(_owner, _spender);

        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= _value, "ERC20: insuficient allowance");
            _approve(_owner, _spender, currentAllowance - _value);
        }
    }
}
