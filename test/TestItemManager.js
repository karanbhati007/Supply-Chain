const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager",accounts =>{
    it(" ... should be able to add and check an Item", async function(){
         const itemManagerInstance = await ItemManager.deployed();
         const itemName = "test1";
         const itemPrice = 400;

         const result = await itemManagerInstance.createItem(itemName,itemPrice, {from: accounts[0]});
         assert.equal(result.logs[0].args._itemIndx,0,"It's not the first item");

         const item = await itemManagerInstance.mp(0);
         assert(item.identifier,itemName,"The identification was different !! ");

    })
});