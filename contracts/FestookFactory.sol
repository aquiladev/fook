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

        Festook token = new Festook(name, symbol, uri);
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
}
