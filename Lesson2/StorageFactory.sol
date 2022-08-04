// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Lesson2/SimpleStorage-4.sol";

/*
    Contact to deploy simpleStorage;
*/
contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageContract() public {

        SimpleStorage simplestore = new SimpleStorage();

        simpleStorageArray.push(simplestore);
    }

    // Address, ABI (Application Binary Interface) always required to interact with a contract. Getters cost gas.
    function storageFactoryStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {

        SimpleStorage simplestore = simpleStorageArray[_simpleStorageIndex];

        simplestore.store(_simpleStorageNumber);
    }

    // views are free that are returning (getters)
    function storageFactoryGet(uint256 _simpleStorageIndex) public view returns(uint256) {

        SimpleStorage simpleStore = simpleStorageArray[_simpleStorageIndex];
        
        return simpleStore.retrieve();
    }
}