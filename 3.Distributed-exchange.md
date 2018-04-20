## Token management

```
addToken(string symbolName,address erc20TokenAddress) onlyowner
hasToken(string symbolName) constant returns(bool)
```

## Funds (token) management

```
depositToken(string symbolName, uint amount) 
withdrawToken(string symbolName, uint amount)
getBalance(string symbolName) constant returns(uint)
```

## Funds (ethereum) management

```
depositEther() payable
withdrawEther(uint amountInWei)
getEtherBalanceInWei() constant returns(uint)
```

## Place orders
```
buyToken(string symbolName,uint priceInWei, uint amount)
sellToken(string symbolName,uint priceInWei, uint amount)
```

## Order management
```
cancelOrder(string symbolName,bool isSellOrder,uint priceInWei,uint offerKey)
getSellOrderBook(string token) constant returns (uint[],uint[])
getBuyOrderBook(string token) constant returns (uint[],uint[])
```

## Market order vs Limit order

* There are two types of order and the distributed exchange will support both
* The market order will get executed directly
* The limit order comes in the order book. The market maximizes the price. It can partially executes order and leaves the remaining size in the order book.

## Data types

We need to hold:
* symbolNames(tokens)
* balances(in ethereum and in tokens)
* an order book for each token vs ether
* a reference to the token address
* who trades token for ether or vice-versa

### Tokens

Token structure:
* symbolName
* address
* balance
* buy orderBook
* sell orderBook

The market will provide a lookup table in the form of idx => Token.
An admin should be able to CRUD new entry in this table.

OrderBook:
* LinkedList
* Points to the highest price for the bids
* Points to the lowest price for the asks

OrderBook structure (sellBook@500wei):
* higherPrice
* lowerPrice
* offers (another structure to all offers at this price)
* offers_index

Offers structure:
* A stack (FIFO) of offers
* Users coming in and meeting the offers will execute based on the order of the stack
* First who came to place the offer will get executed

## Events

The events can be emitted by the contract but can't be accessed by it
The web3.js can read those events
3 parameters can be indexed so we can search it
* Non indexed value will be stored
* Index value can be searched but not retrieved

## Administrative events
* Can add an event
* Can't destroy a token

## Desposit/Withdraw events
* Desposit Ether
* Withdraw Ether
* Deposit Token
* Withdraw Token
* We log who/how many/timestamp and symbolName

## Orders events
* Create Limit Order
* Order fulfilled
* Cancel order
