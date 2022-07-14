// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../Lesson2/SimpleStorage-4.sol";

// inheritace the simplestorage class
contract ExtraStorage is SimpleStorage {

    /* Override functions
        Virtual Override

        overrides but requires virutal on old method and override on overriding function.
    */
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}