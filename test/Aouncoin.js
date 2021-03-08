var Aouncoin = artifacts.require("Aouncoin");

contract("Aouncoin", function(accounts) {

    it("initializes the contract with the correct values", function() {
        return Aouncoin.deployed().then(function(instance) {
            tokenInstance = instance;
            return tokenInstance.name();
        }).then(function(name) {
            assert.equal(name, "Aouncoin", "has the correct name");
            return tokenInstance.symbol();
        }).then(function(symbol) {
            assert.equal(symbol, "AOUN", "has the correct symbol");
            return tokenInstance.standard();
        }).then(function(standard) {
            assert.equal(standard, "Aouncoin v1.0", "has the correct standard");
        });
    });


    it("sets the total supply upon deployment", function() {
        return Aouncoin.deployed().then(function(instance) {
            tokenInstance = instance;
            return tokenInstance.totalSupply();
        }).then(function(totalSupply) {
            // check total supply is equal to value we expect
            assert.equal(totalSupply.toNumber(), 100000, "Sets the total supply to 100,000.");
            return tokenInstance.balanceOf(accounts[0]);
        }).then(function(adminBalance) {
            assert.equal(adminBalance.toNumber(), 100000, "Allocates the initial supply to the admin account.")
        });
    });
});

