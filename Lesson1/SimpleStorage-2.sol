// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
    Arrays
*/

contract SimpleStorage {

    uint256 favoriteNumber;
    //People public person = People({favoriteNumber: 2, name: "Joe"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // unit256[] public favoriteNumbersList;
    // dynamic array non fixed size.
    People[] public people;

    //lowercase people referse to above var, People is the array.
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        people.push(newPerson);

    
        /* order of variables matters the above can also be written in the following way.
            
            People memory newPerson = People(_favoriteNumber,_name);
            people.push(People(_fravoriteNumber,_name));
        */
    }


    function store(uint256 _fravoriteNumber) public {
        favoriteNumber = _fravoriteNumber;
    }

    // view, pure - disallow modification of sate so are free to run unless inside of a function that requires gas.
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

}
