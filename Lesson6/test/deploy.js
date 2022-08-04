const {ethers} = require("hardhat")
const {expect, assert} = require("chai")

describe("SimpleStorage", () => {

    let simpleStorageFactory, simpleStorage

    beforeEach(async function () {
        simpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
        simpleStorage = await simpleStorageFactory.deploy()
    })

    it("Should Start with a fav number of 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        const expectedValue = "0"
        //assert
        //expect
        assert.equal(currentValue.toString(), expectedValue)
    })

    it("Should update when we call store", async function () {
        const expectedValue = 7
        const transactionResponse = await simpleStorage.store("7")
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.retrieve()
        assert.equal(currentValue.toString(), expectedValue)
        //expect(currentValue.toString()).to.equal(expectedValue)
    })

    it("should Add a person to the array", async function () {
        const ExpectNumber = "7"
        const expectName = "Joe"
        const transactionResponse = await simpleStorage.addPerson("Joe","7")
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.people(0);
        assert.equal(currentValue[0].toString(), ExpectNumber)
        assert.equal(currentValue[1].toString(), expectName)
    })

})
