// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal{
    uint256 totalWaves;
    uint256 private seed;
    struct Wave{
        address sender;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;
    mapping(address => uint256) public lastWaveat;

    constructor() payable {
        console.log("HELLO! I AM A SMART CONTRACT");
        seed= (block.timestamp * block.difficulty)% 100;
    }

    function wave(string memory _message) public {

        require(
            lastWaveat[msg.sender] + 15 seconds < block.timestamp,
            "Please wait 15 sec between waves"
        );

        lastWaveat[msg.sender] = block.timestamp;

        totalWaves +=1;
        console.log("%s has waved!",msg.sender);
        waves.push(Wave(msg.sender,_message,block.timestamp));
        console.log("Recieved a new wave message: %s",_message);

        uint256 prizeAmount = 0.01 ether;

        seed = (block.timestamp * block.difficulty + seed)%100;
        if(seed<=50){       
        console.log("%s has won!", msg.sender);
        require(prizeAmount <= address(this).balance,"Trying to withdraw more money than the contract has");
        (bool success, ) = (msg.sender).call{value : prizeAmount}("");
        require(success,"Failed to withdraw money from contract");
        }
    }


    function getAllWaves() public view returns(Wave[] memory){
        return waves;

    }

    function getTotalWaves() public view returns(uint256){
        console.log("We have %d total Waves",totalWaves);
        return totalWaves;
    }
}
