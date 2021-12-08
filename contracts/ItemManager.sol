// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
import "./Item.sol";
import "./Ownable.sol";

contract ItemManager is Ownable{

    enum SupplyChainState{Created,Paid,Delivered}
    event SupplyChainStep(uint _itemIndx,uint _state,address _address);

    struct MItem{
        Item item;
        string identifier;
        ItemManager.SupplyChainState state;
    }
    
    mapping(uint => MItem) public mp;
    uint indx;
    
    function createItem(string memory _identifier,uint _itemPrice) public onlyOwner{
        Item item = new Item(this,_itemPrice,indx);
        mp[indx].item = item;
        mp[indx].identifier = _identifier;
        mp[indx].state = SupplyChainState.Created;

        emit SupplyChainStep(indx,uint(mp[indx].state),address(item));
        indx++;
    }

    function triggerPayment(uint _indx) public payable{
        Item item = mp[_indx].item;
        require(address(item) == msg.sender,"Only items are allowed to update themseleves !"); // didn't understood
        require(item.price() == msg.value,"Not fully paid yet !!");  // reduntant , why item.price "()" ?
        require(mp[_indx].state == SupplyChainState.Created,"Item is futher in the supply");
        mp[_indx].state = SupplyChainState.Paid;

        emit SupplyChainStep(_indx,uint(mp[_indx].state),address(item));
    }


    function triggerDelivery(uint _indx) public onlyOwner{
        require(mp[_indx].state == SupplyChainState.Paid,"Item is further in the supply chain");
        mp[_indx].state = SupplyChainState.Delivered;
        emit SupplyChainStep(_indx,uint(mp[_indx].state),address(mp[_indx].item));
    }


}