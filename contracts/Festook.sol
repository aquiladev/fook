pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "./ERC1155MixedFungibleMintable.sol";
import "./ERC1155Metadata.sol";

contract Festook is ERC1155MixedFungibleMintable, ERC1155Metadata, Ownable {
    // Contract name
    string public name;
    // Contract symbol
    string public symbol;

    string public contractUri;

    constructor(string memory _name, string memory _symbol) public {
        name = _name;
        symbol = _symbol;
    }

    function mintNonFungible(string calldata _uri, address[] calldata _to) external {
        uint256 id = create(_uri, true);
        mintNonFungible(id, _to);
    }

    function mintFungible(string calldata _uri, address[] calldata _to, uint256[] calldata _quantities) external {
        uint256 id = create(_uri, false);
        mintFungible(id, _to, _quantities);
    }

    function uri(uint256 _id) public view returns (string memory) {
        return Strings.strConcat(baseMetadataURI, Strings.uint2str(_id));
    }

    function contractURI() public view returns (string memory) {
        return contractUri;
    }

    /**
    * @dev Will update the base URL of token's URI
    * @param _newBaseMetadataURI New base URL of token's URI
    */
    function setBaseMetadataURI(string memory _newBaseMetadataURI)
        public
        onlyOwner
    {
        _setBaseMetadataURI(_newBaseMetadataURI);
    }

    function setContractURI(string memory _newContractURI)
        public
        onlyOwner
    {
        contractUri = _newContractURI;
    }
}
