pragma solidity ^0.4.13;

contract someContract {
    
    mapping(address => uint) balances;
    
    function deposit() payable {
        balances[msg.sender] += msg.value;
    }
    
    //VERY very bad below
    function withdrawVeryBad1(uint amount) {
        if(balances[msg.sender] >= amount) {
            //bad: we are not checking if we the return value is false
            //sends send along 2300 gas. Let's imagine this address contract tries to 
            //do other things it cannot do that because it will run out of gas
            //send returns false but still we reduce the balance
            msg.sender.send(amount);
            balances[msg.sender] -= amount;
        }
    }
    function withdrawVeryVeryBad2(uint amount) {
        if(balances[msg.sender] >= amount) {
            //we are not sending more gas as the other contract may need more gas
            //so we are calling callfunction
            //the caller contract function may call again withdrawVeryVeryBad2 of the whole amount
            //can do done 1024 times because of the height of the stack
            // So this is better to withdraw the balance BEFORE we send them along
            msg.sender.call.gas(2500000).value(amount)();
            balances[msg.sender] -= amount;
        }
    }
    function withdrawVeryVeryBad3(uint amount) {
        if(balances[msg.sender] >= amount) {
            // Same as withdrawVeryVeryBad2 with the if statement
            // but still very bad as we reduce the amount after
            // even though we are checking on the return value
            if(msg.sender.call.gas(2500000).value(amount)()) {
                balances[msg.sender] -= amount;
            }
        }
    }
    
    function withdrawBad1(uint amount) {
        if(balances[msg.sender] >= amount) {
            //SAFE BY ACCIDENT because send is sending only 2300 gas
            //So the recieving contract cannot do much with 2300 and
            //Definitely not call withdrawBad1
            if(msg.sender.send(amount)) {
                balances[msg.sender] -= amount;
            }
        }
    }
    
    function withdrawOkayish(uint amount) {
        if(balances[msg.sender] >= amount) {
            // OK from the reentrance bugs perspective as we transfer AFTER reducing
            // the amount. We re-throw the exception but still we tranfer only 2300 gas
            balances[msg.sender] -= amount;
            if(!msg.sender.send(amount)) {
               throw;
            }
        }
    }

    function withdrawBad2(uint amount) {
        if(balances[msg.sender] >= amount) {
            //Stil ok from the re-entrance bug issue but we now there is much better than 
            //call.gas(gasAmount).value(amount)() with transfer
            balances[msg.sender] -= amount;
            if(!msg.sender.call.gas(2500000).value(amount)()) {
               throw;
            }
        }
    }
    
    
    //OKAY FUNCTIONS
    
    function withdrawOK(uint amount) {
        if(balances[msg.sender] >= amount) {
            balances[msg.sender] -= amount;
            // Not returning false but directly throwing an Exception
            msg.sender.transfer(amount);
        }
    }
    
    //New Exception handling
    function withdrawGood(uint amount) {
        // Use require statement instead of the if which is state of the art
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }
}
