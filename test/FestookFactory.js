const assert = require('assert')
const { expectEvent, expectRevert } = require('@openzeppelin/test-helpers');

const FestookFactory = artifacts.require('FestookFactory.sol');

contract('FestookFactory', (accounts) => {
    const account = accounts[0];
    let contractInstance;

    beforeEach(async () => {
        contractInstance = await FestookFactory.new({ from: account });
    });

    // it('should', async () => {
    //     // Arrange

    //     // Act
    //     const { logs } = await contractInstance.create('test', 'tst', 'http://test/', { from: account, value: 0 });

    //     // Assert
    //     console.log(logs);
    // });
});