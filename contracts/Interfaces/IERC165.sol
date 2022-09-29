// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

interface IERC165 {
    function supportsInterface (bytes memory InterfaceId) external view returns (bool);
}