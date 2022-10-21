// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.10;

interface IERC721Receiver {
    function onIERC721Receiver (
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns(bytes4);
}