// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
 Basic Solidity Memory, Storage, & Calldata
*/

contract SimpleStorage {

    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    // calldata, memory, storage
    /*
        Memory - Tempory
        Storage - exists outside the function
        calldata - cannot be modified tempoary

        data location only set for array, struct or mappings not required for uint.
    */
    function addPerson(string calldata _name, uint256 _favoriteNumber) public {
            people.push(People(_favoriteNumber,_name));
    }


    function store(uint256 _fravoriteNumber) public {
        favoriteNumber = _fravoriteNumber;
    }


    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

}
