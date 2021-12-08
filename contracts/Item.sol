// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./ItemManager.sol";

contract Item{
    ItemManager itemManager;
    uint public price;
    uint public paidMoney;
    uint public indx;


    constructor(ItemManager _itemManager,uint _price,uint _index){
        itemManager = _itemManager;
        price = _price;
        indx = _index;
    }

    receive() external payable{
        require(msg.value == price, "Please provide Exact Payment !!");
        require(paidMoney == 0,"Item is already paid !!");
        paidMoney += msg.value;
        (bool result, ) = address(itemManager).call{value: msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",indx));
        require(result,"Delivery did not work !!");
    }

    fallback() external{}

}