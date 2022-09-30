// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "../interfaces/IERC165.sol";

abstract contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}