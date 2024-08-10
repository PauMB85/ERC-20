# ERC-20

El estandar ERC-20 es un standar para tokens fungibles, el cual define una serie de metodos que los token deben implementar.
Por ejemplo:

- Transferir tokens
- Leer el balance de tokens
- Approve tokens

Mas info: https://ethereum.org/es/developers/docs/standards/tokens/erc-20/

## ¿Cómo podemos crear nuestro token erc-20?

Un token ERC-20 lo podemos crear de dos formas:

1. Crear un contrato inteligente y que nosotros desarrollemos las funciones y eventos necesarios para el token.
2. Mediante librerías como OpenZeppelin. El cual nos permite extraer de la lógica de nogecio y crearlo en tan solo minutos.

Las funciones básicas que puede tener un ERC-20 son:

```solidity
function name() public view returns (string)
function symbol() public view returns (string)
function decimals() public view returns (uint8)
function totalSupply() public view returns (uint256)
function balanceOf(address _owner) public view returns (uint256 balance)
function transfer(address _to, uint256 _value) public returns (bool success)
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
function approve(address _spender, uint256 _value) public returns (bool success)
function allowance(address _owner, address _spender) public view returns (uint256 remaining)
```

y los eventos que puede emitir un token erc-20 son:

```solidity
event Transfer(address indexed _from, address indexed _to, uint256 _value)
event Approval(address indexed _owner, address indexed _spender, uint256 _value)
```

Además, se puede construir una seria más de funciones, que nos ofrece Openzeppelin par ayudar a mejorar en la creación de nuestro token ERC-20

### Mint

La función `mint` permitite a ciertos usuarios a crear nuevos tokens. Por lo tanto, aumentamos el supply del token.

```solidity
import "@openzeppelin/contracts/access/manager/AccessManaged.sol";

function mint(address to, uint256 amount) public restricted {
    _mint(to, amount);
}
```

### Burn

La función `burn` permite a ciertos usuarios el poder eliminar tokens. Por lo tanto, disminuimos el supply del token.

```solidity
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
```

### Pausable

Esta función permite que las cuentas privilegiadas de pausar el contrato.
Este tipo de funcion puede venir muy bien para que los contratos puedan ser pausados, para evitar que se realicen transacciones innecesarias (cuando hackean los contratos).

```solidity
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/manager/AccessManaged.sol";


function pause() public restricted {
    _pause();
}

function unpause() public restricted {
    _unpause();
}

// The following functions are overrides required by Solidity.

function _update(address from, address to, uint256 value)
    internal
    override(ERC20, ERC20Pausable)
{
    super._update(from, to, value);
}
```

### Permit

Permite a los titulares del token que terceros puedan transferir tokens sin gastar gas.

```solidity
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
```

### Flash Minting

Esta función nos pemrite prestar token sin requerir de una garantia, siempre y cuando esos tokens seand devueltos en la misma transacción.

```solidity
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
```
