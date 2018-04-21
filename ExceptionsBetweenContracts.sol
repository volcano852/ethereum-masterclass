pragma solidity ^0.4.13;


contract secondContract {
    uint public number = 0;
    
    function increaseNumber() {
        number++;
    }
    
    
    function thisThrowsARevert() {
        revert();
    }
    
    
    //anonymous function which gets called when transfer is called
    function() payable {
        thisThrowsARevert();
    }
}


contract TestRevertAssert {
    
    secondContract _secondContract;
    
    function TestRevertAssert() {
        //creating the second contract in the constructor
        _secondContract = new secondContract();
    }
    
    mapping(address => uint) balance;
    
    ////////////////////////////////
    // ASSERT STYLE: ALL GAS USED //
    ////////////////////////////////
    function assertExceptionArrayTooLarge() {
        uint[] memory myArray = new uint[](10);
        myArray[11] = 10;
    }
    
    
    function divideByZero() {
        uint someVar = 0;
        uint someOtherVar = 50;
        uint third = someOtherVar / someVar;
        third = 1;
    }
    
    function shiftByNegativeAmount() {
        uint someVar = 1;
        int shiftVar = -1;
        someVar << shiftVar;
    }
    
    
    function thisAsserts() {
        assert(false); //consumes all gas
    }
    
    ////////////////////////////////
    // REQUIRE STYLE: RETURNS GAS //
    ////////////////////////////////
    
    
    function thisThrows() {
        throw; //require-style exception
    }
    
    function thisRequires() {
        require(false); //consumes no gas
    }
    
    function thisReverts() {
        revert();
    }
    
    
    function throwInSecondContract() {
        _secondContract.thisThrowsARevert();
    }
    
    
    function callSendContractWithTransfer() payable {
        _secondContract.transfer(msg.value);
    }
    
    function changeWithRevert() {
        _secondContract.increaseNumber();
        revert();
        // eventually does not increase the number and revert all changes
        // returns all the remaining gas otherwise it opens doors to DOS attacks
    }
    
    function safeWithdraw(uint amount) {
        require(balance[msg.sender] >= amount);
        require(balance[msg.sender] - amount <= balance[msg.sender]);
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }
    
    /////////////////////////
    // DANGER ZONE BELOW!! //
    /////////////////////////
    
    function callSecondContract() payable {
        //danger because the second contract can call this function again and runs through the gas
        _secondContract.call.gas(100000).value(msg.value)(msg.data);
    }
    
    
    function sendFundsToSecondContract() payable {
        //limited to 2300
        _secondContract.send(msg.value);
        
    }
    
    
    //////////////////////
    // NORMAL FUNCTIONS //
    //////////////////////
    function getNumber() constant returns(uint) {
        return _secondContract.number();
    }
    
    function changeWithoutRevert() {
        _secondContract.increaseNumber();
    }
    
    function depositFunds() payable {
        //overflow check
        uint new_balance = msg.value;
        require(balance[msg.sender] + msg.value >= balance[msg.sender]);
        balance[msg.sender] += new_balance;
    }
    
}
