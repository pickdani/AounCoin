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

    it("transfers token ownership", function() {
        return Aouncoin.deployed().then(function(instance) {
            tokenInstance = instance;
            // attempt a transfer greater than balance of user, should be exception
            // using call here means this does not trigger a transaction
            return tokenInstance.transfer.call(accounts[1], 99999999999);
        }).then(assert.fail).catch(function(error) {
            assert(error.message.indexOf('revert') >= 0, "error message must contain revert");
            return tokenInstance.transfer.call(accounts[1], 25000, {from: accounts[0] });
        }).then(function(success) {
            assert.equal(success, true, "transfer returns true")
            return tokenInstance.transfer(accounts[1], 25000, {from: accounts[0] });
        }).then(function(receipt) {
            assert.equal(receipt.logs.length, 1, "triggers one event");
            assert.equal(receipt.logs[0].event, "Transfer", "should be the Transfer event");
            assert.equal(receipt.logs[0].args._from, accounts[0], "logs the account the tokens are transfered from");
            assert.equal(receipt.logs[0].args._to, accounts[1], "logs the account the tokens are transferred to");
            assert.equal(receipt.logs[0].args._value, 25000, "logs the transfered amount");
            return tokenInstance.balanceOf(accounts[1]);
        }).then(function(balance) {
            assert.equal(balance.toNumber(), 25000, "adds amount to receiving account");
            return tokenInstance.balanceOf(accounts[0]);
        }).then(function(balance) {
            // 100,000 - 25,000 = 75,000 remaining
            assert.equal(balance.toNumber(), 75000, "deducts amount from the sending account");
        });
    });






});

