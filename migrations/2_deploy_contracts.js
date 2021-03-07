// creating an artifact allows ganache to run in js runtime enivornment
const Aouncoin = artifacts.require("Aouncoin");

module.exports = function (deployer) {
  deployer.deploy(Aouncoin);
};
`
