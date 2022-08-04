// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//0.7.6 < unchecked 

contract SafeMathTester {

    uint8 public bigNumber = 255; //unchecked

    function add() public {
        // unchecked { bigNumber = bigNumber + 1; } 
        bigNumber = bigNumber + 1;
    }
}
