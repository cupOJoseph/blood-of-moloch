// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BloodOfMoloch is ERC721, ERC721Enumerable, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    uint256 maxMintable;

    Counters.Counter private _tokenIdCounter;

    Event Reedemed(uint id, address redeemer);

    constructor(uint256 _maxMintable) ERC721("BloodOfMoloch", "BOM") {
        maxMintable = _maxMintable;
    }

    function safeMint(address to) public onlyOwner {
        require(_tokenIdCounter.current() <= maxMintable);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function redeem(uint256 _id) public {
      require(ownerOf(_id) == msg.sender);
      burn(_id);
    }

    function redeemBatch(uint256[] _ids) public{
      for (uint32 i = 0; i < _ids.length; i++) {
        require(ownerOf(_ids[i]) == msg.sender);
        burn(_ids[i]);
      }
    }

    // The following 2 functions are overrides required by Solidity.
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
