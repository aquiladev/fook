pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/payment/PullPayment.sol";
import "./Festook.sol";

contract FestookFactory is Ownable, PullPayment {
    event ChangedFee(address indexed sender, uint256 newFee);
    event ChangedCollector(address indexed sender, address newCollector);
    event Created(address indexed sender, address token);

    uint256 private _fee;
    address private _collector;

    function create(string calldata name, string calldata symbol, string calldata uri) external payable {
        require(msg.value == _fee, "value should be equal to fee amount");

        Festook token = new Festook(name, symbol);
        string memory newUri = strConcat(uri, addressToString(address(token)), "/");
        token.setBaseMetadataURI(newUri);
        token.transferOwnership(msg.sender);

        _asyncTransfer(_collector, msg.value);

        emit Created(msg.sender, address(token));
    }

    function getFee() public view returns (uint256) {
        return _fee;
    }

    function setFee(uint256 fee) public onlyOwner {
        _fee = fee;

        emit ChangedFee(msg.sender, fee);
    }

    function setCollector(address collector) public onlyOwner {
        _collector = collector;

        emit ChangedCollector(msg.sender, collector);
    }

    function addressToString(address _addr) public pure returns(string memory)
    {
        bytes32 value = bytes32(uint256(_addr));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(51);
        str[0] = '0';
        str[1] = 'x';
        for (uint256 i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }

    function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory)
    {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        string memory abc = new string(_ba.length + _bb.length + _bc.length);
        bytes memory babc = bytes(abc);
        uint256 k = 0;
        for (uint256 i = 0; i < _ba.length; i++) babc[k++] = _ba[i];
        for (uint256 i = 0; i < _bb.length; i++) babc[k++] = _bb[i];
        for (uint256 i = 0; i < _bc.length; i++) babc[k++] = _bc[i];
        return string(babc);
    }
}
