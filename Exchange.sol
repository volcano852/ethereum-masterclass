pragma solidity ^0.4.21;

import './FixedSupplyToken.sol';

contract Exchange is Owned {
    
    struct Offer {
        address trader;
        uint amount;
    }
    
    struct OrderBook {
        
        uint higherPrice;
        uint lowerPrice;
        
        mapping(uint => Offer) offers;
        
        //to represent a stack
        uint offers_key;
        uint offer_length;
    }
    
    struct Token {
        string symbolName;
        
        address tokenContract;
        
        // price is the key for order book linkedlist
        mapping(uint => OrderBook) buyOrderBook;
        //HEAD of the linkedlist for the buy order book
        uint currentBuyPrice;
        //TAIL of the linkedlist for the buy order book
        uint lowestBuyPrice;
        uint amountBuyPrices;
        
        // price is the key for order book linkedlist
        mapping(uint => OrderBook) sellOrderBook;
        //HEAD of the linked list for the sell order book
        uint currentSellPrice;
        //TAIL of the linked list for the sell order book
        uint highestSellPrice;
        uint amountSellPrices;
        
        
    }
    
    //uint8, we support maximum 255 contracts as we start from 1
    mapping(uint8 => Token) tokens;
    uint8 tokenIndex;
    
    mapping(address => mapping(uint8 => Token)) tokenBalancesForAddress;
    
    mapping(address => uint) etherBalanceForAddress;
    
    //////////////
    /// EVENTS ///
    //////////////
    
    
    ////////////////////////////////
    /// ETHER DEPOSIT & WITHDRAW ///
    ////////////////////////////////
    
    function depositEther(uint amountInWei) {
        
    }
    
    function withdrawEther(uint amountInWei) {
        
    }
    
    function getBalanceInWei() {
        
    }
    
    ////////////////////////
    /// TOKEN MANAGEMENT ///
    ////////////////////////
    
    // Only admin function
    function addToken(string symbolName,address tokenAddress) onlyOwner {
        
    }
    
    function hasToken(string symbolName) constant returns (bool) {
        
    }
    
    function getSymbolIndex(string symbolName) internal returns (uint8) {
        
    }
    
    
    ////////////////////////////////
    /// TOKEN DEPOSIT & WITHDRAW ///
    ////////////////////////////////
    
    
    function depositToken(string symbolName,uint amount) {
        
    }
    
    function withdrawToken(string symbolName,uint amount) {
        
    }
    
    function getBalanceToken(string symbolName) constant returns (uint) {
        
    }
    
    /////////////////////////////
    /// ORDER BOOK MANAGEMENT ///
    /////////////////////////////
    
    function getBuyOrderBook(string symbolName) constant returns (?) {
        
    }
    
    function getSellOrderBook(string symbolName) constant returns (?) {
        
    }
    
    function buyToken(string symbolName, uint amount, uint priceInWei) {
        
    }
    
    function sellToken(string symbolName, uint amount, uint priceInWei) {
        
    }
    
    function cancelLimitOrder(string symbolName, bool isSellOrder, uint amount, uint priceInWei) {
        
    }
}
