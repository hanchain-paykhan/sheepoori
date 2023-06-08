// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./token/ERC721/ERC721.sol";
import "./token/ERC721/extensions/ERC721URIStorage.sol";
import "./access/Ownable.sol";
import "./utils/Counters.sol";

contract Sheepoori is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    mapping(string => uint8) hashes;
    
    constructor() ERC721("Sheepoori", "SPR") {}
    
    /*
     * @dev Mints a new NFT and assigns it to the recipient.
     * 
     * Requirements:
     * - Only the contract owner can call this function.
     * - The given hash must not have been used before.
     * 
     * @param recipient The address to receive the minted NFT.
     * @param hash The unique hash associated with the NFT.
     * @param metadata The metadata URI of the NFT.
     * @return newItemId The ID of the newly minted NFT.
     */
     
    function mintItem(address recipient, string memory hash, string memory metadata)
        public
        onlyOwner
        returns (uint256)
    {
        require(hashes[hash] != 1);
        hashes[hash] = 1;
        _tokenIdCounter.increment();
        uint256 newItemId = _tokenIdCounter.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, metadata);
        return newItemId;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
