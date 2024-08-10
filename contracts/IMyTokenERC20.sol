// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IMyTokenERC20 {
    // Eventos

    /**
     * @notice Evento que se dispara cuando un usuario transfiere tokens.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @notice Evento que se dispara cuando un usuario aprova tokens.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // Funciones

    /**
     * @notice Devuelve el nombre del token.
     */
    function name() external view returns (string memory);

    /**
     * @notice Devuelve el simbolo del token.
     */
    function symbol() external view returns (string memory);

    /**
     * @notice Devuelve la cantidad de decimales del token.
     */
    function decimals() external view returns (uint8);

    /**
     * @notice Devuelve el total del supply de tokens.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @notice Devuelve el balance de tokens para una dirección(_owner).
     */
    function balanceOf(address _owner) external view returns (uint256 balance);

    /**
     * @notice Transfiere tokens a una dirección(_to) una cierta cantidad (_value)
     */
    function transfer(
        address _to,
        uint256 _value
    ) external returns (bool success);

    /**
     * @notice Un tercero (_from) puede transferir tokens a una dirección(_to) una cierta cantidad (_value),
     * con una autorización previa (approve).
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    /**
     * @notice El propierario de un token puede aprobar una cantidad (_value) de tokens para un tercero (_spender).
     */
    function approve(
        address _spender,
        uint256 _value
    ) external returns (bool success);

    /**
     * @notice Devuelve el balance de tokens para una dirección(_owner), que se aprobaron para un tercero (_spender).
     */
    function allowance(
        address _owner,
        address _spender
    ) external view returns (uint256 remaining);
}
