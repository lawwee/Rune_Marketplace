// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

library Address {
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }
}