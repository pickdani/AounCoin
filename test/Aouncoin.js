var Aouncoin = artifacts.require("Aouncoin");

contract("Aouncoin", function(accounts) {

    it("sets the total supply upon deployment", function() {
        return Aouncoin.deployed().then(function(instance) {
            tokenInstance = instance;
            return tokenInstance.totalSupply();
        }).then(function(totalSupply) {
            // check total supply is equal to value we expect
            assert.equal(totalSupply.toNumber(), 1000000, "sets the total supply to 1,000,000.");
        });
    });
})

