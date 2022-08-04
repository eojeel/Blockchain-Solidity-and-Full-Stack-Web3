// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
    Mapping
*/

contract SimpleStorage {

    uint256 favoriteNumber;

    // create a mapping dictionary to a number.
    mapping(string => uint256) public nameToFoavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;


    function addPerson(string calldata _name, uint256 _favoriteNumber) public {
            people.push(People(_favoriteNumber,_name));
            nameToFoavoriteNumber[_name] = _favoriteNumber;
    }

    function store(uint256 _fravoriteNumber) public virtual {
        favoriteNumber = _fravoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

}
