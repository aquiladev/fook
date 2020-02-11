const FestookFactory = artifacts.require("FestookFactory");

module.exports = function (deployer) {
    deployer.deploy(FestookFactory);
};