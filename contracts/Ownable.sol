// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract Ownable{
    address public owner;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(isOwner(),"You are not the owner !!");
        _;
    }

    function isOwner() public view returns(bool){
        return (owner == msg.sender);
    }


}