// SPDX-License-Identifier: Unlicense 

pragma solidity ^0.8.10;

import "../Interfaces/IERC721.sol";
import "../Interfaces/IERC721Metadata.sol";
import "../Libraries/Address.sol";
import "../Libraries/Strings.sol";
import "./Context.sol";
import "./ERC165.sol";

abstract contract ERC721 is ERC165, IERC721, IERC721Metadata, Context {
    using Address for address;
    using Strings for uint256;

    string private _name;
    string private _symbol;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }

    function _ownerOf(uint256 tokenId) internal view returns (address) {
        return _owners[tokenId];
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }

    function _requireMinted(uint256 tokenId) internal view virtual {
        require (_exists(tokenId), "ERC721: invalid token ID");
    }

    function _approve(address to, uint256 tokenId) internal {
        _tokenApprovals[tokenId] = to;
        emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
    }

    function _setApprovalForAll(address owner, address operator, bool approved) internal {
        require(owner != operator, "ERC721: owner cannot be operator");
        _operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ERC721.ownerOf(tokenId);
        return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal {}

    function _afterTokenTransfer(address from, address to, uint256 tokenId) internal {}

    function _transfer(address from, address to, uint256 tokenId) internal {
        require(ERC721.ownerOf(tokenId) == from, "ERC721: caller does not own token");
        require(to != address(0), "ERC721: token cannot be sent to zero address");

        _beforeTokenTransfer(from, to, tokenId);

        // Check that token transfer was not made by hook
        require(ERC721.ownerOf(tokenId) == from, "ERC721: caller does not own token");

        delete _tokenApprovals[tokenId];

        unchecked {
            _balances[from] -= 1;
            _balances[to] += 1;
        }
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

        _afterTokenTransfer(from, to, tokenId);

    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: cannot mint to a zero address");
        require(!_exists(tokenId), "ERC721: token ID already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        // Check that token transfer was not made by hook
        require(!_exists(tokenId), "ERC721: token ID already minted");
        
        unchecked {
            _balances[to] += 1;
        }

        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual {
        address owner = ERC721.ownerOf(tokenId);

        _beforeTokenTransfer(owner, address(0), tokenId);

        // Update ownership in case token was transferred by _beforetokentransfer 
        owner = ERC721.ownerOf(tokenId);

        delete _tokenApprovals[tokenId];

        unchecked {
            _balances[owner] -= 1;
        }

        delete _owners[tokenId];

        emit Transfer(owner, address(0), tokenId);

        _afterTokenTransfer(owner, address(0), tokenId);
    }

    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "ERC721: zero address is not a valid address");
        return _balances[owner];
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";

    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        address owner = _ownerOf(tokenId);
        require(owner != address(0), "ERC721: invalid token ID");
        return owner;
    }

    function isApprovedForAll(address owner, address operator) public view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function approve(address to, uint256 tokenId) public override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval cannot be set to owner");
        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: caller is not token owner nor approved for all");

        _approve(to, tokenId);
    }

    function getApproved(uint256 tokenId) public view override returns (address) {
        _requireMinted(tokenId);

        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address operator, bool approved) public override {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not owner nor approved to call");

        _transfer(from, to, tokenId);
    }

}