// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SimpleStorage {

    // this gets intalized as 0!
    uint256 public favoriteNumber;

    function store(uint256 _fravoriteNumber) public {
        favoriteNumber = _fravoriteNumber;
    }

    // view, pure - disallow modification of sate so are free to run unless inside of a function that requires gas.
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

}
