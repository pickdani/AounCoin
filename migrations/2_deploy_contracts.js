// creating an artifact allows ganache to run in js runtime enivornment
const Aouncoin = artifacts.require("Aouncoin");

module.exports = function (deployer) {
    // 100k total coin initial supply (ever)
    deployer.deploy(Aouncoin, 100000);
};

